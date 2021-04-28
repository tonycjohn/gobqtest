package main

import (
	"context"
	"fmt"
	"io"
	"sort"
	"sync"

	"github.com/linkedin/goavro"

	bqStorage "cloud.google.com/go/bigquery/storage/apiv1"
	gax "github.com/googleapis/gax-go/v2"
	bqStoragepb "google.golang.org/genproto/googleapis/cloud/bigquery/storage/v1"
	"google.golang.org/grpc"
)

var rpcOpts = gax.WithGRPCOptions(
	grpc.MaxCallRecvMsgSize(1024 * 1024 * 11),
)

func storageTest() {
	ctx := context.Background()
	bqReadClient, err := bqStorage.NewBigQueryReadClient(ctx)
	if err != nil {
		infoLogger.Panicln(err)
	}
	defer bqReadClient.Close()

	//selectedFields := []string{"mkt_breakdown_id", "mkt_breakdown_sdesc"}
	selectedFields := []string{"product_id", "npr_phi_id", "npr_level_from_top", "npr_phi_fds_id", "concept_002_id"}

	readTable := fmt.Sprintf("projects/%s/datasets/%s/tables/%s", projectID, datasetID, tableID)
	tableReadOptions := &bqStoragepb.ReadSession_TableReadOptions{
		SelectedFields: selectedFields,
		//RowRestriction: `period_id=1058`,
	}
	createReadSessionRequest := &bqStoragepb.CreateReadSessionRequest{
		Parent: fmt.Sprintf("projects/%s", projectID),
		ReadSession: &bqStoragepb.ReadSession{
			Table:       readTable,
			DataFormat:  bqStoragepb.DataFormat_AVRO,
			ReadOptions: tableReadOptions,
		},
		MaxStreamCount: 1,
	}
	/*ts, err := ptypes.TimestampProto(time.Unix(0, snapshotMillis*1))
	if err != nil {
		infoLogger.Panicln(err)
	}
	createReadSessionRequest.ReadSession.TableModifiers = &bqStoragepb.ReadSession_TableModifiers{
		SnapshotTime: ts,
	}*/

	//create the session
	session, err := bqReadClient.CreateReadSession(ctx, createReadSessionRequest, rpcOpts)
	if err != nil {
		infoLogger.Panicln(err)
	}
	if len(session.GetStreams()) == 0 {
		infoLogger.Panicln("No streams in session. Consider reading a bigger tablbe")
	}

	//use just one stream for this test
	readStream := session.GetStreams()[0].Name

	ch := make(chan *bqStoragepb.AvroRows)

	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		defer wg.Done()
		if err := processStream(ctx, bqReadClient, readStream, ch); err != nil {
			infoLogger.Panicln("processStream failure -", err)
		}
		close(ch)
	}()

	//Start Avro processing and decoding
	wg.Add(1)
	go func() {
		defer wg.Done()
		err := processAvro(ctx, session.GetAvroSchema().GetSchema(), ch)
		if err != nil {
			infoLogger.Panicln("Error Processing Avro: ", err)
		}

	}()
	wg.Wait()

}

//processStream reads rows from a single storage Stream, and sends
//the Avro data blocks to a channe.
func processStream(ctx context.Context, client *bqStorage.BigQueryReadClient, st string, ch chan<- *bqStoragepb.AvroRows) error {
	var offset int64
	retryLimit := 3

	for {
		retries := 0
		rowStream, err := client.ReadRows(ctx, &bqStoragepb.ReadRowsRequest{
			ReadStream: st,
			Offset:     offset,
		}, rpcOpts)
		if err != nil {
			infoLogger.Panicln(err)
		}

		//process the streamed response
		for {
			r, err := rowStream.Recv()
			if err == io.EOF {
				return nil
			}
			if err != nil {
				retries++
				if retries >= retryLimit {
					infoLogger.Println("processStream retry exhausted", err)
					return fmt.Errorf("processStream retry exhausted")
				}
				break
			}
			rc := r.GetRowCount()
			if rc > 0 {
				offset = offset + rc
				retries = 0
				ch <- r.GetAvroRows()
			}
		}
	}
}

//valueFromTypeMap returns the first value/key in the type map
func valueFromTypeMap(field interface{}) interface{} {
	m, ok := field.(map[string]interface{})
	if !ok {
		return nil
	}
	for _, v := range m {
		return v
	}
	return nil
}

//printDatus prints the decoded row datum
func printDatus(d interface{}) {
	m, ok := d.(map[string]interface{})
	if !ok {
		infoLogger.Println("Failed type assertion", d)
	}
	//Go's map implementation returns keys in random order. So we are sorting before accessing
	keys := make([]string, len(m))
	i := 0
	for k := range m {
		keys[i] = k
		i++
	}
	sort.Strings(keys)
	for _, key := range keys {
		infoLogger.Panicf("%s: %-20v", key, valueFromTypeMap(m[key]))
	}
	infoLogger.Println()

}

//processAvro receives row blocks from a channel, and uses the provided Avro
//schema to decode the blocks into individual rows
func processAvro(ctx context.Context, schema string, ch <-chan *bqStoragepb.AvroRows) error {
	codec, err := goavro.NewCodec(schema)
	if err != nil {
		infoLogger.Panicln(err)
	}

	for {
		select {
		case <-ctx.Done():
			//context was cancelled...stop
			return nil
		case rows, ok := <-ch:
			if !ok {
				//channel closed...stop
				return nil
			}
			undecoded := rows.GetSerializedBinaryRows()
			for len(undecoded) > 0 {
				datum, remainingBytes, err := codec.NativeFromBinary(undecoded)
				if err != nil {
					if err == io.EOF {
						break
					}
					infoLogger.Panicln("Decoding error. Remaining bytes:", len(undecoded), err)
				}
				infoLogger.Println("DATUM - ", datum)
				undecoded = remainingBytes
			}
		}
	}
}

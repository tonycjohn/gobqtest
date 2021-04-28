package main

import (
	"context"
	"time"

	"cloud.google.com/go/bigquery"
)

func queryTest(query string, runNumber int) {
	ctx := context.Background()
	client, err := bigquery.NewClient(ctx, projectID)
	if err != nil {
		infoLogger.Panicln(err)
	}
	defer client.Close()

	q := client.Query(query)
	q.Location = "US"
	q.QueryConfig.DisableQueryCache = true

	startTime := time.Now()
	job, err := q.Run(ctx)
	if err != nil {
		infoLogger.Panicln(err)
	}
	status, err := job.Wait(ctx)
	if err != nil {
		infoLogger.Panicln(err)
	}
	if err := status.Err(); err != nil {
		infoLogger.Panicln(err)
	}

	endTime := time.Now()
	executionTime := endTime.Sub(startTime)
	infoLogger.Println("BQ Query Run:", runNumber, " Executed in: ,", executionTime, ", Job ID:", job.ID())

	wg.Done()
}

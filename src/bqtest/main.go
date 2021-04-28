package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"sync"
)

//StorageTest represents input for storageTest()
type StorageTest struct {
	DatasetID string `json:"datasetid"`
	TableID   string `json:"tableid"`
}

//QueryTest represents input for queryTest()
type QueryTest struct {
	BqQueryFileName string `json:"bqqueryfilename"`
	SfQueryFileName string `json:"sfqueryfilename"`
}

//BqTestConfig represents full configuration
type BqTestConfig struct {
	Runs        int         `json:"runs"`
	Concurrency int         `json:"concurrency"`
	Storage     StorageTest `json:"storagetest"`
	Query       QueryTest   `json:"querytest"`
}

/*const (
	projectID = "nlsn-connect-data-eng-poc"
	datasetID = "PDM_US_AOD_KAO_RMS_200002_5969_A"
	tableID   = "LU_MKT_BREAKDOWN"
	//snapshotMillis = 1
	//configFileName = "\\newDatasetConfig.json"
)*/

const (
	projectID      = "nlsn-connect-data-eng-poc"
	datasetID      = "PDM_US_COKE_RMS_1000436_4273_A" //storageTest
	tableID        = "PRODUCT_FLATTEN"                //storageTest
	configFileName = "\\bqtestConfig.json"
)

var wg = sync.WaitGroup{}
var infoLogger *log.Logger

func init() {
	wd, err := os.Getwd()
	if err != nil {
		panic(err)
	}
	logFileName := wd + "\\bqtestlog.txt"
	logFile, err := os.OpenFile(logFileName, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		panic(err)
	}
	infoLogger = log.New(logFile, "INFO: ", log.Ldate|log.Ltime|log.LUTC|log.Lmicroseconds|log.Lshortfile)
}

func main() {
	var config BqTestConfig
	wd, err := os.Getwd()
	if err != nil {
		infoLogger.Panicln(err)
	}
	configFile, err := os.Open(wd + configFileName)
	if err != nil {
		infoLogger.Panicln(err)
	}
	defer configFile.Close()

	decoder := json.NewDecoder(configFile)
	err = decoder.Decode(&config)
	if err != nil {
		infoLogger.Panicln(err)
	}
	infoLogger.Println("**Test Files: " + config.Query.BqQueryFileName + ", " + config.Query.SfQueryFileName)

	if config.Query.BqQueryFileName != "" {
		bqContent, err := ioutil.ReadFile(config.Query.BqQueryFileName)
		if err != nil {
			infoLogger.Panicln(err)
		}
		bqQuery := string(bqContent)
		queryConcurrencyTest(config.Runs, config.Concurrency, bqQuery)
	}

	if config.Query.SfQueryFileName != "" {
		sfContent, err := ioutil.ReadFile(config.Query.SfQueryFileName)
		if err != nil {
			infoLogger.Panicln(err)
		}
		sfQuery := string(sfContent)
		sfQueryConcurrencyTest(config.Runs, config.Concurrency, sfQuery)
	}

	//storageTest()
}

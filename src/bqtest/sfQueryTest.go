package main

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	_ "github.com/snowflakedb/gosnowflake"
)

const (
	user    = "cdm_ndxmetadata@nielsen.com"
	pwd     = "0LfWjR62bZaHjJmrg3J7"
	account = "nielsen_prod.east-us-2.azure"
	//user    = "tony.john@nielsen.com"
	//pwd     = "Snowing1"
	//account = "nielsen.east-us-2.azure" /*UAT*/
	db     = "CSNLSSYNDPI_PROD"
	schema = "PUBLIC"
	//warehouse = "CS_EXTRACT_WH2_UAT"          /*UAT*/
	warehouse = "SF_PERFTEST_WH"
	//role      = "NIELSENBUY_CS_OD_RPT_USR_RL" /*UAT*/
	role = "NIELSENBUY_CS_OD_BE_RW_ROLE"
)

func sfQueryTest(query string, runNumber int) {
	//infoLogger.Println("SF Query Test-", runNumber)

	connectionString := fmt.Sprintf("%s:%s@%s/%s/%s?warehouse=%s&role=%s", user, pwd, account, db, schema, warehouse, role)
	db, err := sql.Open("snowflake", connectionString)
	if err != nil {
		infoLogger.Panicln(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		infoLogger.Panicln(err)
	}

	ctx := context.Background()
	connection, err := db.Conn(ctx)
	if err != nil {
		infoLogger.Panicln(err)
	}
	_, err = connection.ExecContext(ctx, "ALTER SESSION SET USE_CACHED_RESULT=false")
	if err != nil {
		infoLogger.Panicln(err)
	}
	startTime := time.Now()
	_, err = connection.ExecContext(ctx, query)
	if err != nil {
		infoLogger.Panicln(err)
	}
	endtime := time.Now()
	executionTime := endtime.Sub(startTime)

	infoLogger.Println("SF Query Run:", runNumber, " Executed in: ,", executionTime)

	wg.Done()

}

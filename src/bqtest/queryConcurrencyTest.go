package main

import (
	"time"
)

func queryConcurrencyTest(runs int, concurrency int, bqQuery string) {

	startTime := time.Now()

	for r := 1; r <= runs; r++ {
		infoLogger.Println("BQ RUN ", r, " OF ", runs, " WITH CONCURRENCY ", concurrency)
		for i := 1; i <= concurrency; i++ {
			wg.Add(1)
			go queryTest(bqQuery, i)
		}
		wg.Wait()

	}
	endTime := time.Now()
	runTime := endTime.Sub(startTime)
	infoLogger.Println("BQ TOTAL RUN TIME IS: ", runTime)

}

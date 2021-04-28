package main

import (
	"time"
)

func sfQueryConcurrencyTest(runs int, concurrency int, bqQuery string) {

	startTime := time.Now()

	for r := 1; r <= runs; r++ {
		infoLogger.Println("SF RUN ", r, " OF ", runs, " WITH CONCURRENCY ", concurrency)
		for i := 1; i <= concurrency; i++ {
			wg.Add(1)
			go sfQueryTest(bqQuery, i)
		}
		wg.Wait()

	}
	endTime := time.Now()
	runTime := endTime.Sub(startTime)
	infoLogger.Println("SF TOTAL RUN TIME IS: ", runTime)

}

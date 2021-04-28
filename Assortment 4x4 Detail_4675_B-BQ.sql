with dynamicParentLookup as (
  select 
    f.item_id, 
    product_detail_id, 
    max(product_detail_sdesc) as product_detail_sdesc, 
    max(
      benchmark_mkt_breakdown_type_id
    ) as benchmark_mkt_breakdown_type_id, 
    max(m.RETAILER_MKT_BREAKDOWN_SDESC) as RMarket, 
    max(
      m.BENCHMARK_MKT_BREAKDOWN_TYPE_SDESC
    ) as CMarket, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as RetailerTYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as BenchmarkTYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'ya' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as RetailerLYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'ya' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as BenchmarkLYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_units ELSE NULL END ELSE NULL END
      )
    ) as RetailerTYUnits, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_units ELSE NULL END ELSE NULL END
      )
    ) as BenchmarkTYUnits 
  from 
    nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.FCT_RMS_TOTAL_SALES_ITEM f 
    join (
      select 
        distinct department_id as product_detail_id, 
        department_ldesc as product_detail_sdesc 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PROD_PRODUCT 
      where 
        totalstore_id = -98989898 
        AND department_id = -373
    ) c on f.department_id = c.product_detail_id 
    and f.totalstore_id = -98989898 
    AND f.department_id = -373 
    JOIN (
      select 
        1 as time_group_id, 
        'cp' as time_group, 
        period_id, 
        periodicity_id 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD p, 
        (
          select 
            period_date 
          from 
            nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD 
          where 
            period_id = 1126
        ) s 
      where 
        DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
        and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY)
        and periodicity_id = 1 
      union all 
      select 
        3 as time_group_id, 
        'ya' as time_group, 
        period_ya as period_id, 
        periodicity_id 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD p, 
        (
          select 
            period_date 
          from 
            nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD 
          where 
            period_id = 1126
        ) s 
      where 
        DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY)  
        and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY) 
        and periodicity_id = 1
    ) lp ON f.period_id = lp.period_id 
    JOIN nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.REL_RETAILER_BENCHMARK_SHARE_MKT m ON (
      f.mkt_breakdown_id = m.retailer_mkt_breakdown_id 
      OR f.mkt_breakdown_id = m.benchmark_mkt_breakdown_id
    ) 
  WHERE 
    m.retailer_mkt_breakdown_id = 48688 
    AND benchmark_mkt_breakdown_type_id = 3 
    and f.totalstore_id = -98989898 
    AND f.department_id = -373 
  GROUP BY 
    f.item_id, 
    product_detail_id
), 
dynamicItemLookup as (
  select 
    f.item_id, 
    product_detail_id, 
    max(product_detail_sdesc) as product_detail_sdesc, 
    max(
      benchmark_mkt_breakdown_type_id
    ) as benchmark_mkt_breakdown_type_id, 
    max(m.RETAILER_MKT_BREAKDOWN_SDESC) as RMarket, 
    max(
      m.BENCHMARK_MKT_BREAKDOWN_TYPE_SDESC
    ) as CMarket, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as RetailerTYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as BenchmarkTYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'ya' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as RetailerLYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'ya' THEN f_r_sales_value ELSE NULL END ELSE NULL END
      )
    ) as BenchmarkLYFlag, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_units ELSE NULL END ELSE NULL END
      )
    ) as RetailerTYUnits, 
    sum(
      (
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN f_r_sales_units ELSE NULL END ELSE NULL END
      )
    ) as BenchmarkTYUnits 
  from 
    nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.FCT_RMS_TOTAL_SALES_ITEM f 
    join (
      select 
        distinct item_id as product_detail_id, 
        product_ldesc as product_detail_sdesc 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PROD_PRODUCT 
      where 
        totalstore_id = -98989898 
        AND department_id = -373
    ) c on f.item_id = c.product_detail_id 
    and f.totalstore_id = -98989898 
    AND f.department_id = -373 
    JOIN (
      select 
        1 as time_group_id, 
        'cp' as time_group, 
        period_id, 
        periodicity_id 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD p, 
        (
          select 
            period_date 
          from 
            nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD 
          where 
            period_id = 1126
        ) s 
      where
        DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
        and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY)	  
        and periodicity_id = 1 
      union all 
      select 
        3 as time_group_id, 
        'ya' as time_group, 
        period_ya as period_id, 
        periodicity_id 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD p, 
        (
          select 
            period_date 
          from 
            nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.LU_PER_PERIOD 
          where 
            period_id = 1126
        ) s 
      where 
        DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
        and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY) 
        and periodicity_id = 1
    ) lp ON f.period_id = lp.period_id 
    JOIN nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_B.REL_RETAILER_BENCHMARK_SHARE_MKT m ON (
      f.mkt_breakdown_id = m.retailer_mkt_breakdown_id 
      OR f.mkt_breakdown_id = m.benchmark_mkt_breakdown_id
    ) 
  WHERE 
    m.retailer_mkt_breakdown_id = 48688 
    AND benchmark_mkt_breakdown_type_id = 3 
    and f.totalstore_id = -98989898 
    AND f.department_id = -373 
  GROUP BY 
    f.item_id, 
    product_detail_id
) 
SELECT 
  'Total' as col1, 
  COUNT(1) as col2, 
  SUM(RetailerTYFlag) as col3, 
  SUM(BenchmarkTYFlag) as col4, 
  SUM (RetailerTYFlag) / nullif(
    SUM (
      CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN RetailerTYFlag + BenchmarkTYFlag ELSE CASE WHEN benchmark_mkt_breakdown_type_id IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN BenchmarkTYFlag ELSE NULL END END
    ), 
    0
  ) as col5, 
  SUM(RetailerTYUnits) as col6, 
  SUM(BenchmarkTYUnits) as col7, 
  SUM (RetailerTYUnits) / nullif(
    SUM (
      CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN RetailerTYUnits + BenchmarkTYUnits ELSE CASE WHEN benchmark_mkt_breakdown_type_id IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN BenchmarkTYUnits ELSE NULL END END
    ), 
    0
  ) as col8, 
  product_detail_id as id 
FROM 
  dynamicParentLookup 
WHERE 
  ifnull(RetailerLYFlag,0) = 0 
  AND ifnull(RetailerTYFlag,0) > 0 
  AND ifnull(BenchmarkLYFlag,0) = 0 
  AND ifnull(BenchmarkTYFlag,0) > 0 
GROUP BY 
  id 
UNION ALL 
SELECT 
  max(product_detail_sdesc) as col1, 
  COUNT(1) as col2, 
  SUM(RetailerTYFlag) as col3, 
  SUM(BenchmarkTYFlag) as col4, 
  SUM (RetailerTYFlag) / nullif(
    SUM (
      CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN RetailerTYFlag + BenchmarkTYFlag ELSE CASE WHEN benchmark_mkt_breakdown_type_id IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN BenchmarkTYFlag ELSE NULL END END
    ), 
    0
  ) as col5, 
  SUM(RetailerTYUnits) as col6, 
  SUM(BenchmarkTYUnits) as col7, 
  SUM (RetailerTYUnits) / nullif(
    SUM (
      CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN RetailerTYUnits + BenchmarkTYUnits ELSE CASE WHEN benchmark_mkt_breakdown_type_id IN(
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
        15, 16, 21, 22, 23, 32, 33
      ) THEN BenchmarkTYUnits ELSE NULL END END
    ), 
    0
  ) as col8, 
  product_detail_id as id 
FROM 
  dynamicItemLookup 
WHERE 
  ifnull(RetailerLYFlag,0) = 0 
  AND ifnull(RetailerTYFlag,0) > 0 
  AND ifnull(BenchmarkLYFlag,0) = 0 
  AND ifnull(BenchmarkTYFlag,0) > 0 
GROUP BY 
  id 
ORDER BY 
  col2 DESC NULLS LAST 
--LIMIT 
--  501
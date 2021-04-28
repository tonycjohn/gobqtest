WITH PRODUCT_PRICE AS (
  select 
    max(product_detail_sdesc) as product_detail_sdesc, 
    product_detail_id, 
    max(ean_upc) as ean_upc, 
    max(brand_ldesc) as brand_ldesc, 
    max(category_ldesc) as category_ldesc, 
    max(supercategory_ldesc) as supercategory_ldesc, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
        )
      )
    ) as metric1, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
        )
      )
    ) as metric2, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_units else null end else null end
        )
      )
    ) as metric3, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_units else null end else null end
        )
      )
    ) as metric4, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
        )
      )
    ) as metric5, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
        )
      )
    ) as metric6, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_units else null end else null end
        )
      )
    ) as metric7, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_units else null end else null end
        )
      )
    ) as metric8, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric9, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric10, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric11, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric12, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric13, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric14, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric15, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric16, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric17, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric18, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric19, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric20, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric21, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
        )
      )
    ) as metric22, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 2 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric23, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then case when f.any_no_promo_id = 2 then f_r_sales_units else null end else null end else null end
        )
      )
    ) as metric24 
  from 
    nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.FCT_RMS_ANY_NO_PROMO_ITEM f 
    join (
      select 
        distinct item_id as product_detail_id, 
        product_sdesc as product_detail_sdesc, 
        ean_upc, 
        category_ldesc, 
        supercategory_ldesc, 
        brand_ldesc 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.LU_PROD_PRODUCT 
      where 
        totalstore_id = -98989898 
        AND department_id = -373 
        AND supercategory_id = -573749 
        AND category_id = -573444
    ) c on (
      f.item_id = c.product_detail_id 
      and f.totalstore_id = -98989898 
      AND f.department_id = -373 
      AND f.supercategory_id = -573749 
      AND f.category_id = -573444
    ) 
    join (
      select 
        1 as time_group_id, 
        'cp' as time_group, 
        period_id, 
        periodicity_id 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.LU_PER_PERIOD p, 
        (
          select 
            period_date 
          from 
            nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.LU_PER_PERIOD 
          where 
            period_id = 1126
        ) s 
      where 
        DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
        and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY) 
        and periodicity_id = 1 
      UNION ALL 
      select 
        2 as time_group_id, 
        'ya' as time_group, 
        period_ya as period_id, 
        periodicity_id 
      from 
        nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.LU_PER_PERIOD p, 
        (
          select 
            period_date 
          from 
            nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.LU_PER_PERIOD 
          where 
            period_id = 1126
        ) s 
      where 
        DATE(p.period_date) > DATE_SUB(DATE(s.period_date),INTERVAL 52*7 DAY) 
        and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY)  
        and periodicity_id = 1
    ) lp on f.period_id = lp.period_id 
    join nlsn-connect-data-eng-poc.PDM_US_UNFI_RMS_CPS_1000572_4675_C.REL_RETAILER_BENCHMARK_SHARE_MKT m on (
      f.mkt_breakdown_id = m.retailer_mkt_breakdown_id 
      or f.mkt_breakdown_id = m.benchmark_mkt_breakdown_id 
      or f.mkt_breakdown_id = m.share_mkt_breakdown_id
    ) 
  where 
    m.retailer_mkt_breakdown_id in (48688) 
    and m.benchmark_mkt_breakdown_type_id in (1) 
  group by 
    product_detail_id
) 
SELECT 
  product_detail_sdesc as col1, 
  ean_upc as col2, 
  brand_ldesc as col3, 
  metric1 as col4, 
  metric2 as col5, 
  metric17 / nullif(metric19, 0) as col6, 
  (
    (
      metric17 / nullif(metric19, 0)
    ) - (
      metric21 / nullif(metric23, 0)
    )
  ) as col7, 
  metric18 / nullif(metric20, 0) as col8, 
  (
    (
      metric18 / nullif(metric20, 0)
    ) - (
      metric22 / nullif(metric24, 0)
    )
  ) as col9, 
  (
    metric17 / nullif(metric19, 0)
  ) - (
    metric18 / nullif(metric20, 0)
  ) as col10, 
  metric9 / nullif(metric11, 0) as col11, 
  (
    (
      metric9 / nullif(metric11, 0)
    ) - (
      metric13 / nullif(metric15, 0)
    )
  ) as col12, 
  metric10 / nullif(metric12, 0) as col13, 
  (
    metric10 / nullif(metric12, 0) - (
      metric14 / nullif(metric16, 0)
    )
  ) as col14, 
  (
    metric9 / nullif(metric11, 0)
  ) - (
    metric10 / nullif(metric12, 0)
  ) as col15, 
  metric1 / nullif(metric3, 0) as col16, 
  (
    metric1 / nullif(metric3, 0) - (
      metric5 / nullif(metric7, 0)
    )
  ) as col17, 
  metric2 / nullif(metric4, 0) as col18, 
  (
    metric2 / nullif(metric4, 0) - (
      metric6 / nullif(metric8, 0)
    )
  ) as col19, 
  (
    metric1 / nullif(metric3, 0)
  ) - (
    metric2 / nullif(metric4, 0)
  ) as col20, 
  metric9 / nullif(metric1, 0) as col21, 
  (
    (
      metric9 / nullif(metric1, 0)
    ) - (
      metric13 / nullif(metric5, 0)
    )
  )* 100 as col22, 
  metric10 / nullif(metric2, 0) as col23, 
  (
    (
      metric10 / nullif(metric2, 0)
    ) - (
      metric14 / nullif(metric6, 0)
    )
  )* 100 as col24, 
  (
    (
      metric9 / nullif(metric1, 0)
    ) - (
      metric10 / nullif(metric2, 0)
    )
  ) as col25, 
  (metric1 - metric5) / nullif(metric5, 0) as col26, 
  (metric2 - metric6) / nullif(metric6, 0) as col27, 
  rank() over (
    order by 
      metric1 desc NULLS LAST, 
      product_detail_sdesc
  ) as displayorder, 
  rank() over (
    order by 
      metric1 desc NULLS LAST, 
      product_detail_sdesc
  ) as id 
FROM 
  PRODUCT_PRICE 
where 
  (
    metric17 / nullif(metric19, 0)
  ) - (
    metric18 / nullif(metric20, 0)
  ) > 0 
ORDER BY 
  displayorder 
--limit 
--  500
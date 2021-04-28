select 
  max(c.product_detail_sdesc) as col1, 
  (
    sum(
      (
        case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
      )
    )
  ) as col2, 
  (
    sum(
      (
        case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
      )
    )
  ) as col3, 
  (
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )- nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )
    )/ nullif(
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then f_r_sales_value else null end else null end
            )
          )
        )
      ), 
      0
    )
  ) as col4, 
  (
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )- nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )
    )/ nullif(
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then f_r_sales_value else null end else null end
            )
          )
        )
      ), 
      0
    )
  ) as col5, 
  max(t.metric1) AS col6, 
  max(t.metric2) AS col7, 
  max(t.metric3) AS col8, 
  max(t.metric4) AS col9, 
  max(t.metric5) AS col10, 
  nullif(
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
          )
        )
      )
    ), 
    0
  )/ nullif(
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_eq else null end else null end
          )
        )
      )
    ), 
    0
  ) as col11, 
  nullif(
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )/ nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_eq else null end else null end
              )
            )
          )
        ), 
        0
      )
    ), 
    0
  )- nullif(
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )/ nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then f_r_sales_eq else null end else null end
              )
            )
          )
        ), 
        0
      )
    ), 
    0
  ) as col12, 
  nullif(
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
          )
        )
      )
    ), 
    0
  )/ nullif(
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_eq else null end else null end
          )
        )
      )
    ), 
    0
  ) as col13, 
  nullif(
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )/ nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_eq else null end else null end
              )
            )
          )
        ), 
        0
      )
    ), 
    0
  )/ nullif(
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )/ nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then f_r_sales_eq else null end else null end
              )
            )
          )
        ), 
        0
      )
    ), 
    0
  ) as col14, 
  nullif(
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )/ nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_eq else null end else null end
              )
            )
          )
        ), 
        0
      )
    ), 
    0
  )- nullif(
    (
      nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )/ nullif(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_eq else null end else null end
              )
            )
          )
        ), 
        0
      )
    ), 
    0
  ) as col15, 
  max(t.metric6) AS col16, 
  max(t.metric7) AS col17, 
  max(t.metric8) AS col18, 
  max(t.metric9) AS col19, 
  max(t.metric10) AS col20, 
  max(t.metric11) AS col21, 
  max(t.metric12) AS col22, 
  max(t.metric13) AS col23, 
  max(t.metric14) AS col24, 
  max(t.metric15) AS col25, 
  rank() over (
    order by 
      (
        sum(
          (
            case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else 0 end else 0 end
          )
        )
      ) desc NULLS LAST
  ) AS display_order, 
  c.product_detail_id 
FROM 
  nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.FCT_RMS_TOTAL_SALES_ITEM f 
  join (
    select 
      item_id as product_detail_id, 
      max(product_ldesc) as product_detail_sdesc 
    from 
      nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PROD_PRODUCT 
    where 
      supercategory_id = -303 
    group by 
      product_detail_id
  ) c on (f.item_id = c.product_detail_id) 
  AND f.supercategory_id = -303 
  JOIN (
    select 
      1 as time_group_id, 
      'cp' as time_group, 
      period_id, 
      period_ldesc, 
      periodicity_id 
    from 
      nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD p, 
      (
        select 
          DATE(period_date) as period_date 
        from 
          nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD 
        where 
          period_id = 1128
      ) s 
    where 
      DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
      and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY ) 
      and periodicity_id = 1 
    union all 
    select 
      2 as time_group_id, 
      'ya' as time_group, 
      period_ya as period_id, 
      period_ldesc, 
      periodicity_id 
    from 
      nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD p, 
      (
        select 
          DATE(period_date) as period_date 
        from 
          nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD 
        where 
          period_id = 1128
      ) s 
    where 
      DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
      and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY ) 
      and periodicity_id = 1
  ) lp ON f.period_id = lp.period_id 
  JOIN nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_MKT_BREAKDOWN m ON f.mkt_breakdown_id = m.mkt_breakdown_id 
  AND m.mkt_breakdown_id IN (52874, 49098) 
  LEFT OUTER JOIN (
    SELECT 
      c.product_detail_id, 
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
            )
          )
        )
      )/(
        (
          sum(
            (
              case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      ) as metric1, 
      (
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
              )
            )
          )
        )/(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        )
      )-(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
              )
            )
          )
        )/(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        )
      ) as metric2, 
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
            )
          )
        )
      )/(
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      ) as metric3, 
      (
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
              )
            )
          )
        )/(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        )
      )-(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
              )
            )
          )
        )/(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        )
      ) as metric4, 
      (
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
              )
            )
          )
        )/(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        )
      )-(
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
              )
            )
          )
        )/(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        )
      ) as metric5, 
      (
        (
          sum(
            CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'cp' THEN CASE WHEN f.any_no_promo_id = 2 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      ) as metric6, 
      (
        (
          sum(
            CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'cp' THEN CASE WHEN f.any_no_promo_id = 2 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      )-(
        (
          sum(
            CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'ya' THEN CASE WHEN f.any_no_promo_id = 2 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
          )
        )/ nullif(
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
                )
              )
            )
          ), 
          0
        )
      ) as metric7, 
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
            )
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      ) as metric8, 
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
            )
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      )-(
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
            )
          )
        )/ nullif(
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
                )
              )
            )
          ), 
          0
        )
      ) as metric9, 
      nullif(
        (
          (
            (
              sum(
                CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'cp' THEN CASE WHEN f.any_no_promo_id = 2 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
              )
            )/ nullif(
              (
                sum(
                  (
                    case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
                  )
                )
              ), 
              0
            )
          )
        ), 
        0
      )- nullif(
        (
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_value else null end else null end else null end
                )
              )
            )/ nullif(
              (
                sum(
                  (
                    case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 2 then f_r_sales_eq else null end else null end else null end
                  )
                )
              ), 
              0
            )
          )
        ), 
        0
      ) as metric10, 
      (
        (
          sum(
            CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'cp' THEN CASE WHEN f.any_no_promo_id = 1 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      ) as metric11, 
      (
        (
          sum(
            CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'cp' THEN CASE WHEN f.any_no_promo_id = 1 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      )-(
        (
          sum(
            CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'ya' THEN CASE WHEN f.any_no_promo_id = 1 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 52874 then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      ) as metric12, 
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
            )
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      ) as metric13, 
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
            )
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      )-(
        (
          sum(
            (
              case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
            )
          )
        )/ nullif(
          (
            sum(
              (
                case when f.mkt_breakdown_id = 49098 then case when time_group = 'ya' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
              )
            )
          ), 
          0
        )
      ) as metric14, 
      nullif(
        (
          (
            (
              sum(
                CASE WHEN f.mkt_breakdown_id = 52874 THEN CASE WHEN time_group = 'cp' THEN CASE WHEN f.any_no_promo_id = 1 THEN f_r_sales_value ELSE NULL END ELSE NULL END ELSE NULL END
              )
            )/ nullif(
              (
                sum(
                  (
                    case when f.mkt_breakdown_id = 52874 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
                  )
                )
              ), 
              0
            )
          )
        ), 
        0
      )- nullif(
        (
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_value else null end else null end else null end
                )
              )
            )/ nullif(
              (
                sum(
                  (
                    case when f.mkt_breakdown_id = 49098 then case when time_group = 'cp' then case when f.any_no_promo_id = 1 then f_r_sales_eq else null end else null end else null end
                  )
                )
              ), 
              0
            )
          )
        ), 
        0
      ) as metric15 
    FROM 
      nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.FCT_RMS_ANY_NO_PROMO_ITEM f 
      join (
        select 
          item_id as product_detail_id, 
          max(product_ldesc) as product_detail_sdesc 
        from 
          nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PROD_PRODUCT 
        where 
          supercategory_id = -303 
        group by 
          product_detail_id
      ) c on (f.item_id = c.product_detail_id) 
      AND f.supercategory_id = -303 
      JOIN (
        select 
          1 as time_group_id, 
          'cp' as time_group, 
          period_id, 
          period_ldesc, 
          periodicity_id 
        from 
          nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD p, 
          (
            select 
              DATE(period_date) as period_date 
            from 
              nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD 
            where 
              period_id = 1128
          ) s 
        where 
          DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
          and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY ) 
          and periodicity_id = 1 
        union all 
        select 
          2 as time_group_id, 
          'ya' as time_group, 
          period_ya as period_id, 
          period_ldesc, 
          periodicity_id 
        from 
          nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD p, 
          (
            select 
              DATE(period_date) as period_date 
            from 
              nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_PER_PERIOD 
            where 
              period_id = 1128
          ) s 
        where 
          DATE(p.period_date) > DATE_SUB(DATE(s.period_date), INTERVAL 52*7 DAY) 
          and DATE(p.period_date) <= DATE_SUB(DATE(s.period_date), INTERVAL 0 DAY ) 
          and periodicity_id = 1
      ) lp ON f.period_id = lp.period_id 
      JOIN nlsn-connect-data-eng-poc.PDM_US_COKE_RMS_1000436_4273_A.LU_MKT_BREAKDOWN m ON f.mkt_breakdown_id = m.mkt_breakdown_id 
      AND m.mkt_breakdown_id IN (52874, 49098) 
    GROUP BY 
      c.product_detail_id
  ) t ON f.item_id = t.product_detail_id 
GROUP BY 
  c.product_detail_id 
having 
  col15 > 0 
ORDER BY 
  display_order, 
  col1 
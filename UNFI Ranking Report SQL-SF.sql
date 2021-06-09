--PDM_US_UNFI_RMS_CPS_1000572_4675_B *test comment* *second comment*

with parentquery as (
  select 
    department_id as product_parent_id, 
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
    ) as metric4 
  from 
    fct_rms_total_sales_totalstore_department f 
    join (
      select 
        1 as time_group_id, 
        'cp' as time_group, 
        period_id, 
        periodicity_id 
      from 
        lu_per_period p, 
        (
          select 
            period_date 
          from 
            lu_per_period 
          where 
            period_id = 1128
        ) s 
      where 
        p.period_date > DATEADD(day, -52 * 7, s.period_date) 
        and p.period_date <= DATEADD(day, 0, s.period_date) 
        and periodicity_id = 1 
      UNION ALL 
      select 
        2 as time_group_id, 
        'ya' as time_group, 
        period_ya as period_id, 
        periodicity_id 
      from 
        lu_per_period p, 
        (
          select 
            period_date 
          from 
            lu_per_period 
          where 
            period_id = 1128
        ) s 
      where 
        p.period_date > DATEADD(day, -52 * 7, s.period_date) 
        and p.period_date <= DATEADD(day, 0, s.period_date) 
        and periodicity_id = 1
    ) lp on f.period_id = lp.period_id 
    join rel_retailer_benchmark_share_mkt m on (
      f.mkt_breakdown_id = m.retailer_mkt_breakdown_id 
      or f.mkt_breakdown_id = m.benchmark_mkt_breakdown_id 
      or f.mkt_breakdown_id = m.share_mkt_breakdown_id
    ) 
  where 
    m.retailer_mkt_breakdown_id in (49098) 
    and m.benchmark_mkt_breakdown_type_id in (3) 
    and f.totalstore_id = -98989898 
    AND f.department_id = -371 
  group by 
    product_parent_id
), 
childquery AS (
  SELECT 
    max(p.item_sdesc) as col1, 
    max(p.ean) as col2, 
    max(lvl4.category_ldesc) as col3, 
    max(lvl5.sub_category_ldesc) as col4, 
    max(lvl6.segment_ldesc) as col5, 
    max(lvl7.manufacturer_ldesc) as col6, 
    max(lvl8.brand_ldesc) as col7, 
    rank() over (
      order by 
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else 0 end else 0 end
            )
          )
        ) desc NULLS LAST
    ) as col8, 
    rank() over (
      order by 
        (
          sum(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else 0 end else 0 end
            )
          )
        ) desc NULLS LAST
    ) as col9, 
    (
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      ) / max(pa.metric1)
    ) as col10, 
    (
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      ) / max(pa.metric2)
    ) as col11, 
    sum(
      (
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ) / max(pa.metric1)
      )
    ) over (
      order by 
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        ) desc NULLS LAST, 
        p.item_id desc
    ) as col12, 
    sum(
      (
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
              )
            )
          )
        ) / max(pa.metric2)
      )
    ) over (
      order by 
        (
          sum(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        ) desc NULLS LAST, 
        p.item_id desc
    ) as col13, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
        )
      )
    ) as col14, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
        )
      )
    ) as col15, 
    nullif(
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
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
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
            )
          )
        )
      ), 
      0
    ) as col16, 
    nullif(
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
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
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
            )
          )
        )
      ), 
      0
    ) as col17, 
    (
      (
        nullif(
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
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
                  case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
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
                case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )
    ) as col18, 
    (
      (
        nullif(
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
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
                  case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
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
                case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )
        ), 
        0
      )
    ) as col19, 
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
          )
        )
      )
    )/ nullif(
      (
        avg(
          (
            case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_acv_distribution_w else null end else null end
          )
        )
      ), 
      0
    ) as col20, 
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
          )
        )
      )
    )/ nullif(
      (
        avg(
          (
            case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_acv_distribution_w else null end else null end
          )
        )
      ), 
      0
    ) as col21, 
    (
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      )/ nullif(
        (
          avg(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_acv_distribution_w else null end else null end
            )
          )
        ), 
        0
      )
    )-(
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
            )
          )
        )
      )/ nullif(
        (
          avg(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_acv_distribution_w else null end else null end
            )
          )
        ), 
        0
      )
    ) as col22, 
    (
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      )/ nullif(
        (
          avg(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_acv_distribution_w else null end else null end
            )
          )
        ), 
        0
      )
    )-(
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
            )
          )
        )
      )/ nullif(
        (
          avg(
            (
              case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_acv_distribution_w else null end else null end
            )
          )
        ), 
        0
      )
    ) as col23, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_units else null end else null end
        )
      )
    ) as col24, 
    (
      sum(
        (
          case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_units else null end else null end
        )
      )
    ) as col25, 
    (
      (
        nullif(
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_units else null end else null end
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
                  case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_units else null end else null end
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
                case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_units else null end else null end
              )
            )
          )
        ), 
        0
      )
    ) as col26, 
    (
      (
        nullif(
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_units else null end else null end
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
                  case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_units else null end else null end
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
                case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_units else null end else null end
              )
            )
          )
        ), 
        0
      )
    ) as col27, 
    (
      (
        avg(
          (
            case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_acv_distribution_w else null end else null end
          )
        )
      )/ 100
    ) as col28, 
    (
      (
        avg(
          (
            case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_acv_distribution_w else null end else null end
          )
        )
      )/ 100
    ) as col29, 
    to_date(
      min(
        CASE WHEN f.mkt_breakdown_id = retailer_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN firstweekselling ELSE NULL END ELSE NULL END
      )
    ) as col30, 
    to_date(
      min(
        CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'cp' THEN firstweekselling ELSE NULL END ELSE NULL END
      )
    ) as col31, 
    (
      (
        (
          sum(
            (
              case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
            )
          )
        )
      )/ nullif(
        (
          (
            sum(
              (
                CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id 
                AND benchmark_mkt_breakdown_type_id IN(
                  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
                  15, 16, 21, 22, 23, 32, 33
                ) 
                AND time_group = 'cp' THEN f_r_sales_value ELSE CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
                  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
                  15, 16, 21, 22, 23, 32, 33
                ) 
                AND time_group = 'cp' THEN f_r_sales_value ELSE NULL END END
              )
            )
          )
        ), 
        0
      )
    ) as col32, 
    nullif(
      (
        (
          (
            (
              sum(
                (
                  case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
                )
              )
            )
          )/ nullif(
            (
              (
                sum(
                  (
                    CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id 
                    AND benchmark_mkt_breakdown_type_id IN(
                      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
                      15, 16, 21, 22, 23, 32, 33
                    ) 
                    AND time_group = 'cp' THEN f_r_sales_value ELSE CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
                      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
                      15, 16, 21, 22, 23, 32, 33
                    ) 
                    AND time_group = 'cp' THEN f_r_sales_value ELSE NULL END END
                  )
                )
              )
            ), 
            0
          )
        )* 100
      ), 
      0
    )- nullif(
      (
        (
          (
            sum(
              (
                case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
              )
            )
          )/ nullif(
            (
              (
                sum(
                  (
                    CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id 
                    AND benchmark_mkt_breakdown_type_id IN(
                      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
                      15, 16, 21, 22, 23, 32, 33
                    ) 
                    AND time_group = 'ya' THEN f_r_sales_value ELSE CASE WHEN benchmark_mkt_breakdown_type_id NOT IN(
                      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 
                      15, 16, 21, 22, 23, 32, 33
                    ) 
                    AND time_group = 'ya' THEN f_r_sales_value ELSE NULL END END
                  )
                )
              )
            ), 
            0
          )
        )* 100
      ), 
      0
    ) as col33, 
    (
      (
        sum(
          (
            case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
          )
        )
      )*(
        (
          (
            (
              nullif(
                (
                  (
                    sum(
                      (
                        case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
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
                        case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
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
                      case when f.mkt_breakdown_id = retailer_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
                    )
                  )
                )
              ), 
              0
            )
          )* 100
        )-(
          (
            (
              nullif(
                (
                  (
                    sum(
                      (
                        case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'cp' then f_r_sales_value else null end else null end
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
                        case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
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
                      case when f.mkt_breakdown_id = benchmark_mkt_breakdown_id then case when time_group = 'ya' then f_r_sales_value else null end else null end
                    )
                  )
                )
              ), 
              0
            )
          )* 100
        )
      )
    )/ 100 as col34, 
    ZEROIFNULL(
      sum(
        (
          CASE WHEN f.mkt_breakdown_id = benchmark_mkt_breakdown_id THEN CASE WHEN time_group = 'ya' THEN f_r_sales_value ELSE NULL END ELSE NULL END
        )
      )
    ) as col35, 
    1 as display_order, 
    p.item_id as id 
  from 
    fct_rms_total_sales_item f 
    join lu_prod_item p on f.item_id = p.item_id 
    join (
      select 
        mkt_breakdown_id, 
        item_id, 
        to_date(
          min(period_date)
        ) as firstweekselling 
      from 
        fct_rms_total_sales_item f 
        join lu_per_period p on f.period_id = p.period_id 
        join rel_retailer_benchmark_share_mkt m on (
          f.mkt_breakdown_id = m.retailer_mkt_breakdown_id 
          or f.mkt_breakdown_id = m.benchmark_mkt_breakdown_id 
          or f.mkt_breakdown_id = m.share_mkt_breakdown_id
        ) 
      where 
        m.retailer_mkt_breakdown_id in (49098) 
        and m.benchmark_mkt_breakdown_type_id in (3) 
        and totalstore_id = -98989898 
        AND department_id = -371 
      group by 
        mkt_breakdown_id, 
        item_id
    ) fws on f.mkt_breakdown_id = fws.mkt_breakdown_id 
    and f.item_id = fws.item_id 
    join lu_prod_totalstore lvl1 on f.totalstore_id = lvl1.totalstore_id 
    join lu_prod_department lvl2 on f.department_id = lvl2.department_id 
    join lu_prod_supercategory lvl3 on f.supercategory_id = lvl3.supercategory_id 
    join lu_prod_category lvl4 on f.category_id = lvl4.category_id 
    join lu_prod_sub_category lvl5 on f.sub_category_id = lvl5.sub_category_id 
    join lu_prod_segment lvl6 on f.segment_id = lvl6.segment_id 
    join lu_prod_manufacturer lvl7 on f.manufacturer_id = lvl7.manufacturer_id 
    join lu_prod_brand lvl8 on f.brand_id = lvl8.brand_id 
    join lu_prod_product lvl9 on f.item_id = lvl9.item_id 
    JOIN parentquery pa ON 1 = 1 
    join (
      select 
        1 as time_group_id, 
        'cp' as time_group, 
        period_id, 
        periodicity_id 
      from 
        lu_per_period p, 
        (
          select 
            period_date 
          from 
            lu_per_period 
          where 
            period_id = 1128
        ) s 
      where 
        p.period_date > DATEADD(day, -52 * 7, s.period_date) 
        and p.period_date <= DATEADD(day, 0, s.period_date) 
        and periodicity_id = 1 
      UNION ALL 
      select 
        2 as time_group_id, 
        'ya' as time_group, 
        period_ya as period_id, 
        periodicity_id 
      from 
        lu_per_period p, 
        (
          select 
            period_date 
          from 
            lu_per_period 
          where 
            period_id = 1128
        ) s 
      where 
        p.period_date > DATEADD(day, -52 * 7, s.period_date) 
        and p.period_date <= DATEADD(day, 0, s.period_date) 
        and periodicity_id = 1
    ) lp on f.period_id = lp.period_id 
    join rel_retailer_benchmark_share_mkt m on (
      f.mkt_breakdown_id = m.retailer_mkt_breakdown_id 
      or f.mkt_breakdown_id = m.benchmark_mkt_breakdown_id 
      or f.mkt_breakdown_id = m.share_mkt_breakdown_id
    ) 
    JOIN lu_per_period lpp ON f.period_id = lpp.period_id 
  where 
    m.retailer_mkt_breakdown_id in (49098) 
    and m.benchmark_mkt_breakdown_type_id in (3) 
    and f.totalstore_id = -98989898 
    AND f.department_id = -371 
  group by 
    p.item_id, 
    p.item_sdesc
) 
SELECT 
  DISTINCT * 
FROM childquery

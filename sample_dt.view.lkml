view: sample_dt {
  sql_table_name: (SELECT 1 as id, STR_TO_DATE('2019-01-01', '%Y-%m-%d') as order_date
                    UNION ALL
                  SELECT 2 as id, STR_TO_DATE('2019-01-01', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 1 as id, STR_TO_DATE('2019-01-02', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 2 as id, STR_TO_DATE('2019-01-02', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 3 as id, STR_TO_DATE('2019-01-03', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 4 as id, STR_TO_DATE('2019-01-03', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 5 as id, STR_TO_DATE('2019-01-04', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 5 as id, STR_TO_DATE('2019-01-05', '%Y-%m-%d') as order_date
                  UNION ALL
                  SELECT 6 as id, STR_TO_DATE('2019-01-06', '%Y-%m-%d') as order_date
  ) ;;
 dimension: id {}
dimension: order_date {
  type:date
  convert_tz: no
}

dimension: count_of_dist_ids_before_this_date {
  type: number
  sql: (select count(distinct a.id) from ${sample_dt.SQL_TABLE_NAME} as a where a.order_date <= {{_view._name}}.order_date) ;;
}
measure: count_dist_ids_before_this_date_measure {
  type: number
  sql: ${count_of_dist_ids_before_this_date} ;;
}

measure: count_d {
  type: count_distinct
  sql: ${id} ;;
}
  measure: count_d_joined {
    view_label: "Sample Dt"
    type: count_distinct
    sql: ${id} ;;
  }

}

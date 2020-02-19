view: events {
  sql_table_name: demo_db.events ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: type_id {
    type: number
    sql: ${TABLE}.type_id ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
# dimension: test {
#   type: string
#   sql: ${count} ;;
# }


  measure: count_no_drill_fields {
    label: "Count"
    type: count
    value_format_name: decimal_3
  }

  measure: some_count {
    type: count
    drill_fields: [count_no_drill_fields]
  }

  measure: median_test {
    type: median
    sql: 1 ;;

  }
}

view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [id, users.first_name,users.last_name,created_date]

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
      year,
      day_of_year
    ]
    sql: ${TABLE}.created_at ;;
  }

  measure: first_order {
  type: date_time
  sql: min(${created_raw}) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
#     drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
}

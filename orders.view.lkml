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
      hour,
      day_of_month,
      week,
      day_of_week,
      day_of_week_index,
      month,
      month_name,
      quarter,
      year,
      day_of_year,
      fiscal_quarter,
      fiscal_quarter_of_year
    ]
    sql: ${TABLE}.created_at ;;
  }

  measure: first_order {
  type: date_time
  sql: min(${created_raw}) ;;
  }

  measure: days_since_first_order{
    type: number
    sql: ${first_order}::date - current_date();;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    ;;
    link: {
      label: "Click Here"
      url: "https://github.com/utilitywarehouse/data-warehouse-documentation/wiki/Data-Dictionary:-Partner-Account#{{ _field._name }}"

  }}
  filter: stat {
    type: string
    required_fields: [status]
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
  measure: percent_previous {
    type: percent_of_previous
    sql: ${count} ;;
  }

  measure: user_ordered_list {
    type: list
    list_field: user_id
  }

#   measure: count_of_orders_list{
#     type: count_distinct
#     sql: ${user_ordered_list} ;;
#   }


}

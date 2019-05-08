view: orders {
  sql_table_name: demo_db.orders;;

  parameter: test_param {
    type: string
  }


  filter: some_filter {
    type: number
    sql: {% condition some_filter %} ${id} {% endcondition %} AND {% condition some_filter %} ${user_id} {% endcondition %} ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [id, users.first_name,users.last_name,created_date]
    action: {
      label: "Send Email to Distribution Manager"
      url: "https://hooks.zapier.com/hooks/catch/abcdefghijk_this_is_a_bad_link"
      icon_url: "https://zapier.com/brand/assets/images/logos/zapier-logomark.png"
    }
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time_of_day,
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
      fiscal_month_num,
      fiscal_quarter_of_year,
      second
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: diff_date_created_date_and_now {
    type: number
    sql: DATEDIFF(${created_raw},CURRENT_DATE) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: <font size="5">{{value}}</font> ;;
  }

#   dimension: test_status {
#     type: string
#     sql: ${TABLE}.status ;;
#   }

  dimension: yesno_test {
    type: yesno
    sql: 1=1 ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count


    drill_fields: [orders.id, orders.user_id, orders.created_date, orders.diff_date_created_date_and_now]

  }

  measure: count_distinct_of_user_ids {
    type: count_distinct
    sql: ${user_id} ;;

  }

  measure: eaoifnwoenfe {
    type: string
    sql: CASE WHEN ${count_distinct_of_user_ids} > 100 THEN 'Hello' ELSE 'GOODBYE' END ;;
  }


  set: some_set {
    fields: [orders.tier_id]
  }
}

view: orders {
  sql_table_name: demo_db.orders;;

  parameter: test_param {
    type: string
  }

  filter: date_filter {
    type: date
  }

  dimension: previous_year_filter {
    type: yesno
    sql: YEAR(date_add({% date_start date_filter %},Interval -1 YEAR) ) = ${created_year} ;;
  }

  dimension: yesno_date {
    type: yesno
    sql: {% condition date_filter %} ${created_raw} {% endcondition %} ;;
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

  filter: date_time_param {
    type: string
  }

  dimension: yesnoafterparam {
    type: yesno
    sql: ${created_raw} >= TIMESTAMP({% parameter date_time_param %}) ;;
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
      minute15,
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
#     html: {{value | date:"%H:%M"}} ;;
  }

  dimension: diff_date_created_date_and_now {
    type: number
    sql: DATEDIFF(${created_raw},CURRENT_DATE) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
#     html: <font size="5">{{value}}</font> ;;
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
#     html:
#     {% if value > 100 %}
#     <font color="darkgreen"><img src="https://cdn.emojidex.com/emoji/px32/nerd_face%28smiley%29.png?1442200539"> {{ rendered_value }}</font>
#     {% elsif value > 50 %}
#     <font color="goldenrod">{{ rendered_value }}</font>
#     {% else %}
#     <font color="darkred">{{ rendered_value }}</font>
#     {% endif %} ;;

    drill_fields: [orders.id, orders.user_id, orders.created_date, orders.diff_date_created_date_and_now]

  }

  measure: percentage {
    type: percent_of_total
    sql: ${count} ;;
    value_format_name: percent_2
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

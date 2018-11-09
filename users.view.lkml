view: users {
  sql_table_name: demo_db.users ;;


##############################################################

  filter: some_filter {
    type: yesno
  }

  measure: test_count {
    type: number
    drill_fields: [id]
    sql: CASE WHEN {% condition some_filter %} 'no' {% endcondition %} THEN ${count} WHEN {% condition some_filter%} 'yes' {% endcondition %} THEN ${count_distinct_of_first_names} ELSE NULL END ;;
  }

##############################################################

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [id,first_name,last_name,orders.id]
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
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
      month_name
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;

  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }


  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  measure: count {
    type: count
  }

  measure: count_distinct_of_first_names {
    type: count_distinct
    sql: ${first_name} ;;
  }

  measure: median_test {
    type: median
    sql: ${age} ;;
    drill_fields: [age,count]
  }

  measure: field_name {
    type: list
    list_field: state
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}

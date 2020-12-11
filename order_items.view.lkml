view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: percent_change {
    type: number
    sql: ${products.count}/${count} ;;
    html: {% if percent_change._value >= 1 %}
    {{ negative_concat._value }}
    {% else %}
    {{ positive_concat._value }}
    {% endif %}
    ;;
  }
  measure: negative_concat {
    type: string
    sql: concat("🔻", ${percent_change} ,${products.count}) ;;
  }

  measure: positive_concat {
    type: string
    sql: concat("🔺", ${percent_change} , ${products.count}) ;;
  }

  measure: count {
    type: count
    drill_fields: [orders.id,orders.created_date,orders.diff_date_created_date_and_now, users.email,users.city,users.state,users.country, products.brand,products.item_name,products.sku]
  }
}

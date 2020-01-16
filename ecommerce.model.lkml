connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
# include: "*.dashboard"

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}
datagroup: scheduling {
  sql_trigger: SELECT HOUR(CURTIME())  ;;
}
explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# explore: products {
#   sql_always_where: {% if products.turn_on_filter._parameter_value == "true" %} ${brand} LIKE '%'||${brand}||'%'
#         {% else %} 1=1
#         {% endif %};;
#
# }

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  sql_always_where: {% if users.turn_on_filter._parameter_value == "true" %} ${state} LIKE '&'||${city}||'&'
  {% else %} 1=1
  {% endif %};;




}

explore: users_nn {}

explore: user_facts {}

connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
<<<<<<< HEAD
# include: "*.dashboard"
=======
include: "*.dashboard"
#
# week_start_day: tuesday
#
# explore: test_orders {
#   view_name: orders
#   persist_for: "1 minutes"
# }
#
# # TALA IS HACKING INTO THE MAINFARME
# # TALA IS HACKING INTO THE MAINFARME
# # TALA IS HACKING INTO THE MAINFARME
# # TALA IS HACKING INTO THE MAINFARME
# # TALA IS HACKING INTO THE MAINFARME
# # TALA IS HACKING INTO THE MAINFARME
#


>>>>>>> branch 'master' of git@github.com:philip-martinelli/ecom.git

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
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
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
  sql_always_where: {% if orders.date_filter._is_filtered %}
  ${created_year} >= YEAR(date_add({% date_start orders.date_filter %},Interval -1 YEAR) )  AND ${created_year} < YEAR(date_add({% date_start orders.date_filter %},Interval 1 YEAR) )
  {% else %}
  1=1
  {% endif %};;
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id}=${orders.id} ;;
    relationship: one_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id};;
    relationship:many_to_one}

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
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
<<<<<<< HEAD
  sql_always_where: {% if users.turn_on_filter._parameter_value == "true" %} ${state} LIKE '&'||${city}||'&'
  {% else %} 1=1
  {% endif %};;




=======
  access_filter: {
    field: state
    user_attribute: state
  }
>>>>>>> branch 'master' of git@github.com:philip-martinelli/ecom.git
}

explore: users_nn {}

explore: user_facts {}

connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
#include: "*.dashboard"

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

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  access_filter: {
    field: state
    user_attribute: state
  }
  join: user_data {
    sql_on: ${orders.id}=${user_data.id} ;;
  }
  join: ndt {
    sql_on: ${users.id}=${ndt.id} ;;
    relationship: one_to_one
  }
  join: orders {
    sql_on: ${orders.user_id} = ${users.id};;
  }

  }

explore: users_nn {}
explore: sample_dt {
  fields: [ALL_FIELDS*,-sample_dt.count_d_joined]
  join: sample_dt_self {
    from: sample_dt
    type: inner
    fields:[sample_dt_self.count_d_joined]
    sql_on: ${sample_dt.order_date} >= ${sample_dt_self.order_date} ;;
  }
}

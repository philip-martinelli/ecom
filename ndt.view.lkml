include: "ecommerce.model.lkml"
view: ndt {
  derived_table: {
    explore_source: users {column: id {field: users.id}
      column: oid {field: orders.id}
      column: ndtfield {field: user_data.id }
  }}
    dimension: id {}
}

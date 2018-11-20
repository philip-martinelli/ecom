view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    label: "This field needs a really long name to test if the field selector is broken 1"
    type: string
    sql: ${TABLE}.brand ;;
    drill_fields: [item_name,brand,department]
  }

  dimension: category {
    label: "This field needs a really long name to test if the field selector is broken 2"
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: is_male {
    type: yesno
    sql: ${TABLE}.department = 'Men' ;;
  }

  dimension: department {
    label: "This field needs a really long name to test if the field selector is broken 3"
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    label: "This field needs a really long name to test if the field selector is broken 4"
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    label: "This field needs a really long name to test if the field selector is broken 5"
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count, count]
  }
}

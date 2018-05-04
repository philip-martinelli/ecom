view: sql_runner_query {
  derived_table: {
    sql: SELECT * FROM metadata_maps;
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: results {
    type: string
    sql: ${TABLE}.Results ;;
  }

  set: detail {
    fields: [results]
  }
}

view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: test_drop_down {
    type: average
    sql: ${id} ;;
    html:
    hola Min: {{id._linked_value}}
     <br>
     hola Mean: {{id._linked_value}}
     <br>
     Max: {{id._linked_value}};;

    }
  dimension: brand_test {
    type: string
    sql:
    case when ${category} not like "Suits" then Null else  ${category} end;;

    }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    drill_fields: [item_name,brand,department]

    link: {
      label: "Brand Dashboard"
      url: "https://dcl.dev.looker.com/dashboards/234" #This should actually link out to a dashboard
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension: products_brand_split_word {
    type: string
    sql: ${brand};;
    html:
    {% assign words = {{value}} | split: ' ' %}
    {% assign numwords = 0 %}
    {% for word in words %}
    {{ word }}
    {% assign numwords = numwords | plus: 1 %}
    {% assign mod = numwords | modulo: 1 %}
    {% if mod == 0 %}
    <br>
    {% endif %}
    {% endfor %} ;;
  }

  dimension: products_brand_split_n_char {
    type: string
    sql: ${brand} ;;
    html:
    {% assign words_lenggth = {{value}} | size %}
    {% assign start_p = 0 %}
    {% assign lenggth = 3 %}
    {% for i in (1..words_lenggth) %}
    {% assign tempp = i | modulo: lenggth %}
      {% if tempp == 0 %}
        {{ value | slice:  start_p, lenggth }}<br>
        {% assign start_p = start_p | plus: lenggth %}
      {% else %}
        {%continue%}
      {% endif %}
    {% endfor %}
    ;;
  }

#


  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: is_male {
    type: yesno
    sql: ${TABLE}.department = 'Men' ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  parameter: rank_paramter{
      type: unquoted
    label: "Rank1"
    allowed_value: {
      label: "Daily"
      value: "3.333"
    }
#     allowed_value: {
#       label: "Weekly"
#       value: "2"
#     }
    }
  dimension: selector {
    type: string
    sql: {% if  rank_paramter._parameter_value  == '3.333' %} ${item_name}
          {% endif %}   ;;
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

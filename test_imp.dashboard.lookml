- dashboard: test_imp
  title: test_imp
  layout: newspaper
  elements:
  - title: Order status
    name: Order status
    model: ecommerce
    explore: orders
    type: table
    fields: [orders.status, orders.count]
    filters: {}
    sorts: [orders.count desc]
    limit: 500
    query_timezone: Europe/Dublin
    listen:
      Status filter: orders.status
    row: 0
    col: 0
    width: 8
    height: 6
  filters:
  - name: Status filter
    title: Status filter
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ecommerce
    explore: orders
    listens_to_filters: []
    field: orders.status
  - name: Other filter
    title: Other filter
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ecommerce
    explore: orders
    listens_to_filters: []
    field: orders.status

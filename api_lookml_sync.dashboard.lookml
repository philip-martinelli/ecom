- dashboard: api_sync_dashboard
  title: API_sync_dashboard
  layout: newspaper
  elements:
  - title: Orders_last_3_month
    name: Orders_last_3_month
    model: ecommerce
    explore: orders
    type: table
    fields: [orders.status, orders.count, orders.created_month]
    pivots: [orders.created_month]
    fill_fields: [orders.created_month]
    filters:
      orders.created_month: 3 months ago for 3 months
    sorts: [orders.count desc 0, orders.created_month]
    limit: 500
    query_timezone: Europe/Dublin
    row: 0
    col: 0
    width: 8
    height: 6

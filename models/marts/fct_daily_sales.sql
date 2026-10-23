{{ config(materialized='table') }}

SELECT
    DATE(item_created_at) AS sales_date,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(*) AS items_sold,

    COUNT(DISTINCT user_id) AS customers,

    ROUND(SUM(sale_price), 2) AS revenue,

    ROUND(SUM(gross_profit), 2)
        AS gross_profit,

    ROUND(
        SAFE_DIVIDE(
            SUM(sale_price),
            COUNT(DISTINCT order_id)
        ), 2
    ) AS avg_order_value

FROM {{ ref('int_order_details') }}

WHERE item_status = 'Complete'

GROUP BY sales_date

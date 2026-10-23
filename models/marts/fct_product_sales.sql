{{ config(materialized='table') }}

SELECT
    product_id,
    product_name,
    category,
    brand,

    COUNT(*) AS items_sold,

    COUNT(DISTINCT order_id) AS orders,

    ROUND(SUM(sale_price), 2) AS revenue,

    ROUND(SUM(gross_profit), 2)
        AS gross_profit

FROM {{ ref('int_order_details') }}

WHERE item_status = 'Complete'

GROUP BY
    product_id,
    product_name,
    category,
    brand

{{ config(materialized='table') }}

WITH customer_orders AS (
    SELECT
        user_id,
        COUNT(DISTINCT order_id)
            AS total_orders,
        ROUND(SUM(sale_price), 2)
            AS lifetime_revenue,
        MAX(DATE(item_created_at))
            AS last_purchase_date
    FROM {{ ref('int_order_details') }}
    WHERE item_status = 'Complete'
    GROUP BY user_id
)

SELECT
    u.user_id,
    u.country,
    u.city,
    u.traffic_source,
    u.user_created_at,

    COALESCE(c.total_orders, 0)
        AS total_orders,

    COALESCE(c.lifetime_revenue, 0)
        AS lifetime_revenue,

    c.last_purchase_date,

    CASE
        WHEN COALESCE(c.total_orders, 0) >= 2
            THEN 'Repeat Customer'
        WHEN COALESCE(c.total_orders, 0) = 1
            THEN 'One-time Customer'
        ELSE 'No Purchase'
    END AS customer_segment

FROM {{ ref('stg_users') }} u
LEFT JOIN customer_orders c
    ON u.user_id = c.user_id

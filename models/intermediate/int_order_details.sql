{{ config(materialized='view') }}

WITH order_items AS (
    SELECT *
    FROM {{ ref('stg_order_items') }}
),

orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

products AS (
    SELECT *
    FROM {{ ref('stg_products') }}
),

users AS (
    SELECT *
    FROM {{ ref('stg_users') }}
)

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.user_id,
    oi.product_id,

    o.order_status,
    oi.item_status,
    o.order_created_at,
    oi.item_created_at,

    p.product_name,
    p.category,
    p.brand,
    p.cost,
    oi.sale_price,

    u.country,
    u.city,
    u.traffic_source,

    oi.sale_price - p.cost AS gross_profit

FROM order_items oi

LEFT JOIN orders o
    ON oi.order_id = o.order_id

LEFT JOIN products p
    ON oi.product_id = p.product_id

LEFT JOIN users u
    ON oi.user_id = u.user_id

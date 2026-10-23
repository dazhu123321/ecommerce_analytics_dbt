SELECT
    id AS order_item_id,
    order_id,
    user_id,
    product_id,
    status AS item_status,
    sale_price,
    created_at AS item_created_at
FROM {{ source('ecommerce', 'order_items') }}

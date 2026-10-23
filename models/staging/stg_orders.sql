SELECT
    order_id,
    user_id,
    status AS order_status,
    created_at AS order_created_at,
    shipped_at,
    delivered_at,
    returned_at,
    num_of_item AS item_count
FROM {{ source('ecommerce', 'orders') }}

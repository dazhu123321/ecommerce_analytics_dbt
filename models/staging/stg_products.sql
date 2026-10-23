SELECT
    id AS product_id,
    name AS product_name,
    category,
    brand,
    department,
    cost,
    retail_price
FROM {{ source('ecommerce', 'products') }}

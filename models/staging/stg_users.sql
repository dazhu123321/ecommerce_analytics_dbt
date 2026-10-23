SELECT
    id AS user_id,
    first_name,
    last_name,
    email,
    age,
    gender,
    country,
    city,
    traffic_source,
    created_at AS user_created_at
FROM {{ source('ecommerce', 'users') }}

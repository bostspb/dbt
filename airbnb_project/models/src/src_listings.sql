WITH raw_listings AS (
    SELECT
        id,
        name,
        listing_url,
        room_type,
        minimum_nights,
        host_id,
        price,
        created_at,
        updated_at
    FROM {{ source('airbnb', 'listings') }}
)
SELECT
    id AS listing_id,
    name AS listing_name,
    listing_url,
    room_type,
    minimum_nights,
    host_id,
    price AS price_str,
    created_at,
    updated_at
FROM
    raw_listings
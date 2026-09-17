{{
  config(
    materialized = 'incremental',
    unique_key = 'listing_id',
    )
}}

SELECT 
LISTING_ID,
HOST_ID,
PROPERTY_TYPE,
ROOM_TYPE,
CITY,
COUNTRY,
ACCOMMODATES,
BEDROOMS,
BATHROOMS,
PRICE_PER_NIGHT,
{{Tag('PRICE_PER_NIGHT')}} AS Tagging,
CREATED_AT
FROM {{ref('bronze_listings') }}
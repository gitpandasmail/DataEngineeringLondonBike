SELECT
    station_id,
    station_name,
    district
FROM {{ source('bikes', 'dim_bike_station') }}

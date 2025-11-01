WITH
joined AS (
    SELECT
        w.ob_time,
        w.wind_speed_g,
        w.has_prcp,
        w.air_temperature_g,
        b.duration_time,
        b.date_id,
        b.time_id,
        b.bike_mode,
        b.start_station_id,
        b.end_station_id,
        count(*) AS nr_of_bike_rides
    FROM {{ ref('stg_weather_observations')}} AS w
    LEFT JOIN {{ref('stg_bike_ride_fact_table')}} AS b
        ON w.ob_id = b.ob_id
    GROUP BY
        w.ob_time,
        w.wind_speed_g,
        w.has_prcp,
        w.air_temperature_g,
        b.duration_time,
        b.date_id,
        b.time_id,
        b.bike_mode,
        b.start_station_id,
        b.end_station_id
)

SELECT * FROM joined
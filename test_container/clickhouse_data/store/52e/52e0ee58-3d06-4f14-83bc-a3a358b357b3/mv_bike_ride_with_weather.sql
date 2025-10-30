ATTACH MATERIALIZED VIEW _ UUID 'c069c1a1-9bdb-478c-91c9-f958e49c6673' TO INNER UUID 'cc629315-55ec-4c64-b0f2-c9e87edd010b'
(
    `ob_id` UInt32,
    `date_id` UInt32,
    `time_id` UInt32,
    `start_station_id` UInt32,
    `end_station_id` UInt32,
    `ride_begin_time` DateTime,
    `ride_end_time` DateTime,
    `duration_time` Float32,
    `duration_ms` UInt64,
    `bike_mode` String,
    `wind_speed_g` Float32,
    `air_temperature_g` Float32,
    `is_weekend` UInt8,
    `time_of_day` String
)
ENGINE = MergeTree
ORDER BY (date_id, start_station_id)
SETTINGS index_granularity = 8192
AS SELECT
    f.ob_id AS ob_id,
    f.date_id AS date_id,
    f.time_id AS time_id,
    f.start_station_id AS start_station_id,
    f.end_station_id AS end_station_id,
    f.ride_begin_time AS ride_begin_time,
    f.ride_end_time AS ride_end_time,
    f.duration_time AS duration_time,
    f.duration_ms AS duration_ms,
    f.bike_mode AS bike_mode,
    w.wind_speed_g AS wind_speed_g,
    w.air_temperature_g AS air_temperature_g,
    d.is_weekend AS is_weekend,
    t.time_of_day AS time_of_day
FROM default.bike_ride_fact_table AS f
LEFT JOIN default.dim_weather_observations AS w ON f.ob_id = w.ob_id
LEFT JOIN default.dim_date AS d ON f.date_id = d.date_id
LEFT JOIN default.dim_time AS t ON f.time_id = t.time_id

ATTACH TABLE _ UUID 'cc629315-55ec-4c64-b0f2-c9e87edd010b'
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

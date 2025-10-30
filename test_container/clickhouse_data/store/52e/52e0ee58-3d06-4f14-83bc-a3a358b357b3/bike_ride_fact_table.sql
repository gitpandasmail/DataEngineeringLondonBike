ATTACH TABLE _ UUID '46abc244-850e-445a-b78a-5b0b01c48ff9'
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
    `bike_mode` String
)
ENGINE = MergeTree
ORDER BY (date_id, time_id, start_station_id, end_station_id)
SETTINGS index_granularity = 8192

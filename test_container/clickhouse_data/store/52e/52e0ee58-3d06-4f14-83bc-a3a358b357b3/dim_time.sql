ATTACH TABLE _ UUID '8cdf86f3-7526-4aea-8303-75ab09c8b20f'
(
    `time_id` UInt32,
    `hour` UInt8,
    `minute` UInt8,
    `is_summer_time` UInt8,
    `time_of_day` String,
    `is_peak` UInt8,
    `peak_type` String
)
ENGINE = MergeTree
ORDER BY time_id
SETTINGS index_granularity = 8192

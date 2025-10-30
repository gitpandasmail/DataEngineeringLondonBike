ATTACH TABLE _ UUID '16b8c0eb-3ffb-4ddc-9f18-17907938ae53'
(
    `date_id` UInt32,
    `day` UInt8,
    `week` UInt8,
    `month` UInt8,
    `year` UInt16,
    `day_of_week` String,
    `is_weekend` UInt8,
    `season` String,
    `is_holiday` UInt8,
    `holiday_name` String
)
ENGINE = MergeTree
ORDER BY date_id
SETTINGS index_granularity = 8192

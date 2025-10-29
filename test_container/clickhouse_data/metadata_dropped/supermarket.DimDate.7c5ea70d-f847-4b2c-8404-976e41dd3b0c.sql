ATTACH TABLE _ UUID '7c5ea70d-f847-4b2c-8404-976e41dd3b0c'
(
    `DateKey` UInt32,
    `FullDate` Date,
    `Year` UInt16,
    `Month` UInt8,
    `Day` UInt8,
    `DayOfWeek` String
)
ENGINE = MergeTree
ORDER BY DateKey
SETTINGS index_granularity = 8192

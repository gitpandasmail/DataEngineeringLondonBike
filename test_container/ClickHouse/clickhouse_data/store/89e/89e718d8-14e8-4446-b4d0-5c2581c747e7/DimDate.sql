ATTACH TABLE _ UUID '39207095-c57a-48b6-8ef4-1c738aaa96a7'
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

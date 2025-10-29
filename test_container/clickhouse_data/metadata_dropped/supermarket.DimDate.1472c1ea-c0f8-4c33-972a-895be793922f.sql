ATTACH TABLE _ UUID '1472c1ea-c0f8-4c33-972a-895be793922f'
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

ATTACH TABLE _ UUID '811090bf-84bd-4333-827e-7f0db146358e'
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

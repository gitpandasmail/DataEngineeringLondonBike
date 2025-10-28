ATTACH TABLE _ UUID '8b426304-e58c-4875-ac5d-08d7dae4b81a'
(
    `StoreKey` UInt32,
    `StoreName` String,
    `City` String,
    `Region` String
)
ENGINE = MergeTree
ORDER BY StoreKey
SETTINGS index_granularity = 8192

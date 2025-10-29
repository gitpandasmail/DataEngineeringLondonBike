ATTACH TABLE _ UUID '7b3b27b5-8f8b-4058-a19b-f7366dcc6a8e'
(
    `StoreKey` UInt32,
    `StoreName` String,
    `City` String,
    `Region` String
)
ENGINE = MergeTree
ORDER BY StoreKey
SETTINGS index_granularity = 8192

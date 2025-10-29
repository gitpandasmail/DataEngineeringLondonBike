ATTACH TABLE _ UUID '09c02ca8-fdb5-4b27-8cc0-4ff6065dc90b'
(
    `StoreKey` UInt32,
    `StoreName` String,
    `City` String,
    `Region` String
)
ENGINE = MergeTree
ORDER BY StoreKey
SETTINGS index_granularity = 8192

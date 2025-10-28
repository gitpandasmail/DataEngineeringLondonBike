ATTACH TABLE _ UUID 'd8019536-374b-4113-a252-63cdcee421c8'
(
    `StoreKey` UInt32,
    `StoreName` String,
    `City` String,
    `Region` String
)
ENGINE = MergeTree
ORDER BY StoreKey
SETTINGS index_granularity = 8192

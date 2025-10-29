ATTACH TABLE _ UUID 'a1d93f56-ef0c-45b5-b81b-2f5796ce9cbb'
(
    `ProductKey` UInt32,
    `ProductName` String,
    `Category` String,
    `Brand` String
)
ENGINE = MergeTree
ORDER BY ProductKey
SETTINGS index_granularity = 8192

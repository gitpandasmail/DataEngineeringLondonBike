ATTACH TABLE _ UUID '9d35f8de-3085-4a01-be4f-21c72326fc12'
(
    `ProductKey` UInt32,
    `ProductName` String,
    `Category` String,
    `Brand` String
)
ENGINE = MergeTree
ORDER BY ProductKey
SETTINGS index_granularity = 8192

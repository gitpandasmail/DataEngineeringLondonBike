ATTACH TABLE _ UUID '8b905f78-2260-46a0-a829-96b7a1edb711'
(
    `ProductKey` UInt32,
    `ProductName` String,
    `Category` String,
    `Brand` String
)
ENGINE = MergeTree
ORDER BY ProductKey
SETTINGS index_granularity = 8192

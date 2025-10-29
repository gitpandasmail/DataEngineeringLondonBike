ATTACH TABLE _ UUID '35eb913a-df1b-4b98-9534-4340046edbc3'
(
    `ProductKey` UInt32,
    `ProductName` String,
    `Category` String,
    `Brand` String
)
ENGINE = MergeTree
ORDER BY ProductKey
SETTINGS index_granularity = 8192

ATTACH TABLE _ UUID '5b094554-c92d-49cc-af6c-64f75c01d038'
(
    `PaymentKey` UInt32,
    `PaymentType` String
)
ENGINE = MergeTree
ORDER BY PaymentKey
SETTINGS index_granularity = 8192

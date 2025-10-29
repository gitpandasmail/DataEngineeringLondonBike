ATTACH TABLE _ UUID 'c6adf7e3-ea38-4599-ab3b-b049f88ef5fe'
(
    `PaymentKey` UInt32,
    `PaymentType` String
)
ENGINE = MergeTree
ORDER BY PaymentKey
SETTINGS index_granularity = 8192

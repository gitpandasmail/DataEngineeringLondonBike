ATTACH TABLE _ UUID '02e49bfa-a734-49c8-bf69-a5d010fc1031'
(
    `PaymentKey` UInt32,
    `PaymentType` String
)
ENGINE = MergeTree
ORDER BY PaymentKey
SETTINGS index_granularity = 8192

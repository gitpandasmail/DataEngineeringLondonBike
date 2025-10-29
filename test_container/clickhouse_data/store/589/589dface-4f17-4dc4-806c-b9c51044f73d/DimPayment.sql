ATTACH TABLE _ UUID '7f32d1e8-f6ae-4bb1-b4f7-ad7b27091cfe'
(
    `PaymentKey` UInt32,
    `PaymentType` String
)
ENGINE = MergeTree
ORDER BY PaymentKey
SETTINGS index_granularity = 8192

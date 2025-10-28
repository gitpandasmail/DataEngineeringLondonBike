ATTACH TABLE _ UUID 'a2b59a8f-4f24-44e6-82e7-a982d1826d89'
(
    `SupplierKey` UInt32,
    `SupplierName` String,
    `ContactInfo` String
)
ENGINE = MergeTree
ORDER BY SupplierKey
SETTINGS index_granularity = 8192

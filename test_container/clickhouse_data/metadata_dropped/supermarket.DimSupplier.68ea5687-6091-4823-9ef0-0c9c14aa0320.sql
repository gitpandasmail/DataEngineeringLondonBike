ATTACH TABLE _ UUID '68ea5687-6091-4823-9ef0-0c9c14aa0320'
(
    `SupplierKey` UInt32,
    `SupplierName` String,
    `ContactInfo` String
)
ENGINE = MergeTree
ORDER BY SupplierKey
SETTINGS index_granularity = 8192

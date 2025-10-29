ATTACH TABLE _ UUID 'd6ba8c05-a17a-4742-afff-dba9c8da7425'
(
    `SupplierKey` UInt32,
    `SupplierName` String,
    `ContactInfo` String
)
ENGINE = MergeTree
ORDER BY SupplierKey
SETTINGS index_granularity = 8192

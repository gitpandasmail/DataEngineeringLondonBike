ATTACH TABLE _ UUID '988abbcb-d074-40da-b8f0-9c274d9e72e7'
(
    `SupplierKey` UInt32,
    `SupplierName` String,
    `ContactInfo` String
)
ENGINE = MergeTree
ORDER BY SupplierKey
SETTINGS index_granularity = 8192

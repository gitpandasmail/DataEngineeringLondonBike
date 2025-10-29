ATTACH TABLE _ UUID 'ccabf9dd-b740-4330-84b6-49d6960ba74d'
(
    `SaleID` UInt64,
    `DateKey` UInt32,
    `StoreKey` UInt32,
    `ProductKey` UInt32,
    `SupplierKey` UInt32,
    `CustomerKey` UInt32,
    `PaymentKey` UInt32,
    `Quantity` UInt16,
    `SalesAmount` Decimal(10, 2),
    `FullDate` Date
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(FullDate)
ORDER BY (FullDate, StoreKey, ProductKey)
SETTINGS index_granularity = 8192

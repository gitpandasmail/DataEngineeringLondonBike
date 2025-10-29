ATTACH TABLE _ UUID 'c054d090-5506-4f76-b325-a5711da65078'
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

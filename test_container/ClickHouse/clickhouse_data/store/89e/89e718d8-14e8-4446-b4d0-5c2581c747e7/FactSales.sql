ATTACH TABLE _ UUID '4059e284-3e99-44fd-947a-bb013cef4cb0'
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

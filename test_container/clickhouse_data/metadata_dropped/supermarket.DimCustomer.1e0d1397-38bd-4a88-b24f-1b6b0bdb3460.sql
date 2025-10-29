ATTACH TABLE _ UUID '1e0d1397-38bd-4a88-b24f-1b6b0bdb3460'
(
    `CustomerKey` UInt32,
    `CustomerID` UInt32,
    `FirstName` String,
    `LastName` String,
    `Segment` String,
    `City` String,
    `ValidFrom` Date,
    `ValidTo` Date
)
ENGINE = MergeTree
ORDER BY CustomerKey
SETTINGS index_granularity = 8192

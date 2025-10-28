ATTACH TABLE _ UUID '5c78fe7b-1379-4bd9-b721-84623cb809e8'
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

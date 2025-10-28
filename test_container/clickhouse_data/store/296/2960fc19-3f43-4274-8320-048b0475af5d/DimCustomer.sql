ATTACH TABLE _ UUID '5783438c-adca-4b77-84cd-635455f8453b'
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

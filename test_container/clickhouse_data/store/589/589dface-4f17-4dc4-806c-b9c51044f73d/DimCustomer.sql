ATTACH TABLE _ UUID '6a01f830-3d3d-4a7e-afb6-69095f53dec2'
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

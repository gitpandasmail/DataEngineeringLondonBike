ATTACH TABLE _ UUID '7f48afc8-0097-49c2-8fdd-c5f8716b7ca1'
(
    `hostname` LowCardinality(String) COMMENT 'Hostname of the server executing the query.' CODEC(ZSTD(1)),
    `event_date` Date COMMENT 'Event date.' CODEC(Delta(2), ZSTD(1)),
    `event_time` DateTime COMMENT 'Event time.' CODEC(Delta(4), ZSTD(1)),
    `code` Int32 COMMENT 'Error code.' CODEC(ZSTD(1)),
    `error` LowCardinality(String) COMMENT 'Error name.' CODEC(ZSTD(1)),
    `value` UInt64 COMMENT 'Number of errors happened in time interval.' CODEC(ZSTD(3)),
    `remote` UInt8 COMMENT 'Remote exception (i.e. received during one of the distributed queries).' CODEC(ZSTD(1))
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_date)
ORDER BY (event_date, event_time)
SETTINGS index_granularity = 8192
COMMENT 'Contains history of error values from table system.errors, periodically flushed to disk.\n\nIt is safe to truncate or drop this table at any time.'

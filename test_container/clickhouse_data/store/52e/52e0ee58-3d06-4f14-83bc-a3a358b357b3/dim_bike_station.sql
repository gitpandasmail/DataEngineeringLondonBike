ATTACH TABLE _ UUID 'ee8737c2-646a-49a3-bcd9-70868dfc3c88'
(
    `station_id` UInt32,
    `station_name` String,
    `district` String
)
ENGINE = MergeTree
ORDER BY station_id
SETTINGS index_granularity = 8192

ATTACH TABLE _ UUID '679ab39d-f347-4de2-925b-e25fa09a3e16'
(
    `ob_id` UInt32,
    `ob_time` DateTime,
    `wind_direction` Float32,
    `wind_speed_g` Float32,
    `air_temperature_g` Float32,
    `has_prcp` UInt8,
    `prcp_amt_g` Float32,
    `prst_wx_id` UInt32,
    `cld_tlt_amt_id` UInt32,
    `cld_base_ht` Float32,
    `ground_state_id` UInt32
)
ENGINE = MergeTree
ORDER BY ob_id
SETTINGS index_granularity = 8192

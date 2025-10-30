



-- Dimension: Weather Observations
CREATE TABLE dim_weather_observations
(
    ob_id UInt32,
    ob_time DateTime,
    wind_direction Float32,
    wind_speed_g Float32,
    air_temperature_g Float32,
    has_prcp UInt8,
    prcp_amt_g Float32,
    prst_wx_id UInt32,
    cld_tlt_amt_id UInt32,
    cld_base_ht Float32,
    ground_state_id UInt32
)
ENGINE = MergeTree
ORDER BY ob_id;


-- Dimension: Bike Station
CREATE TABLE dim_bike_station
(
    station_id UInt32,
    station_name String,
    district String
)
ENGINE = MergeTree
ORDER BY station_id;


-- Dimension: Date
CREATE TABLE dim_date
(
    date_id UInt32,
    day UInt8,
    week UInt8,
    month UInt8,
    year UInt16,
    day_of_week String,
    is_weekend UInt8,
    season String,
    is_holiday UInt8,
    holiday_name String
)
ENGINE = MergeTree
ORDER BY date_id;


-- Dimension: Time
CREATE TABLE dim_time
(
    time_id UInt32,
    hour UInt8,
    minute UInt8,
    is_summer_time UInt8,
    time_of_day String,
    is_peak UInt8,
    peak_type String
)
ENGINE = MergeTree
ORDER BY time_id;


-- Fact Table: Bike Ride
CREATE TABLE bike_ride_fact_table
(
    ob_id UInt32,
    date_id UInt32,
    time_id UInt32,
    start_station_id UInt32,
    end_station_id UInt32,
    ride_begin_time DateTime,
    ride_end_time DateTime,
    duration_time Float32,
    duration_ms UInt64,
    bike_mode String
)
ENGINE = MergeTree
ORDER BY (date_id, time_id, start_station_id, end_station_id);


CREATE MATERIALIZED VIEW mv_bike_ride_with_weather
ENGINE = MergeTree
ORDER BY (date_id, start_station_id)
AS
SELECT 
    f.ob_id AS ob_id,
    f.date_id AS date_id,
    f.time_id AS time_id,
    f.start_station_id AS start_station_id,
    f.end_station_id AS end_station_id,
    f.ride_begin_time AS ride_begin_time,
    f.ride_end_time AS ride_end_time,
    f.duration_time AS duration_time,
    f.duration_ms AS duration_ms,
    f.bike_mode AS bike_mode,
    w.wind_speed_g AS wind_speed_g,
    w.air_temperature_g AS air_temperature_g,
    d.is_weekend AS is_weekend,
    t.time_of_day AS time_of_day
FROM bike_ride_fact_table AS f
LEFT JOIN dim_weather_observations AS w ON f.ob_id = w.ob_id
LEFT JOIN dim_date AS d ON f.date_id = d.date_id
LEFT JOIN dim_time AS t ON f.time_id = t.time_id;
-- 1. How much does temperature affect the number of daily and hourly bike rentals?
-- Hourly demo query (works the same if we join by date instead of hour):
SELECT COUNT(br.ride_id) AS total_rides, wo.air_temperature
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
GROUP BY wo.air_temperature
ORDER BY total_rides DESC;

-- 2. How much precipitation and wind speed significantly reduce bike usage?
-- Hourly info demo query:
SELECT COUNT(br.ride_id) AS total_rides, wo.wind_speed, wo.prcp_amt
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
GROUP BY wo.wind_speed, wo.prcp_amt
ORDER BY total_rides DESC;

-- 3. Can we forecast bike demand at different stations based on upcoming weather conditions?
SELECT COUNT(br.ride_id) AS total_rides, wobrs.station_id, br.station_name, wo.wind_speed, wo.wind_direction, wo.prcp_amt, wo.msl_pressure, wo.dewpoint, wo.drv_hr_sun_dur
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
LEFT JOIN bike_station AS bs
	ON bs.station_id = wobrs.station_id
GROUP BY wobrs.station_id, wo.wind_speed, wo.wind_direction, wo.prcp_amt, wo.msl_pressure, wo.dewpoint, wo.drv_hr_sun_dur
ORDER BY wobrs.station_id;

-- 4. Which times of day are most sensitive to weather changes in terms of bike usage?
SELECT COUNT(br.ride_id) AS total_rides, wo.wind_speed, wo.wind_direction, wo.prcp_amt, wo.msl_pressure, wo.dewpoint, wo.drv_hr_sun_dur
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
GROUP BY wo.wind_speed, wo.wind_direction, wo.prcp_amt, wo.msl_pressure, wo.dewpoint, wo.drv_hr_sun_dur;

-- 5. What is the threshold of "bad weather" beyond which bike usage drops sharply?
SELECT COUNT(br.ride_id) AS total_rides, wo.wind_speed, wo.prcp_amt, wo.drv_hr_sun_dur
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
GROUP BY wo.wind_speed, wo.prcp_amt, wo.drv_hr_sun_dur
ORDER BY wo.wind_speed ASC, wo.prcp_amt ASC, wo.drv_hr_sun_dur DESC;

-- 6. How much does the weather change the average duration of rides?
SELECT COUNT(br.ride_id) AS total_rides, br.duration_time, wo.wind_speed, wo.prcp_amt, wo.drv_hr_sun_dur
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
GROUP BY wo.wind_speed, wo.prcp_amt, wo.drv_hr_sun_dur
ORDER BY br.duration_ms DESC;

-- 7. How does weather affect ebike vs bike usage?
SELECT COUNT(br.ride_id) AS total_rides, b.bike_mode, wo.wind_speed, wo.prcp_amt, wo.drv_hr_sun_dur
FROM weather_observations_bike_ride_station AS wobrs
LEFT JOIN weather_observations AS wo
	ON wo.ob_id = wobrs.ob_id
LEFT JOIN bike_ride AS br
	ON br.ride_id = wobrs.ride_id
	AND DATE_TRUNC(‘hour’, br.begin_time) = DATE_TRUNC(‘hour, wo.ob_time)
LEFT JOIN bike AS b
	ON b.bike_id = wobrs.
GROUP BY b.bike_mode, wo.wind_speed, wo.prcp_amt, wo.drv_hr_sun_dur
ORDER BY total_rides DESC;
SELECT
    f.start_station_id,
    avg(f.duration_time) AS avg_duration,
    avg(w.air_temperature_g) AS avg_temp,
    avg(w.wind_speed_g) AS avg_wind_speed,
    any(t.time_of_day) AS time_of_day,
    any(d.is_weekend) AS is_weekend
FROM bike_ride_fact_table AS f
LEFT JOIN dim_weather_observations AS w ON f.ob_id = w.ob_id
LEFT JOIN dim_date AS d ON f.date_id = d.date_id
LEFT JOIN dim_time AS t ON f.time_id = t.time_id
GROUP BY f.start_station_id

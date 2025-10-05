-- Table for Weather Observations
CREATE TABLE weather_observation(
    ob_id SERIAL PRIMARY KEY,
    ob_time TIMESTAMP NOT NULL,
    wind_speed_unit_id VARCHAR(1),
    wind_direction INT,
    wind_speed NUMERIC(15, 5),
    msl_pressure NUMERIC(15, 5),
    air_temperature NUMERIC(5, 2),
    dewpoint NUMERIC(15, 5),
    drv_hr_sun_dur NUMERIC(15, 5),
    prcp_amt  NUMERIC(15, 5)
)

-- Table for Bike Rides
CREATE TABLE bike_ride(
    ride_id SERIAL PRIMARY KEY,
    begin_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    duration_time VARCHAR(20),
    duration_ms INT
)

-- Table for Bike Stations
CREATE TABLE bike_station(
    station_id SERIAL PRIMARY KEY,
    station_name VARCHAR(100)
)

-- Table for Bike Stations
CREATE TABLE bike(
    bike_id SERIAL PRIMARY KEY,
    bike_mode VARCHAR(20)
)

-- JUNCTION TABLE: Weather Observation and Bike Ride data
CREATE TABLE weather_observation_bike_ride_station(
    ride_id INT,
    ob_id INT,
    bike_id INT,
    start_station_id INT,
    end_station_id INT,
    PRIMARY KEY (ride_id, ob_id, bike_id, start_station_id),
    CONSTRAINT fk_ride
        FOREIGN KEY(ride_id)
        REFERENCES bike_ride(ride_id),
    CONSTRAINT fk_observation
        FOREIGN KEY(ob_id)
        REFERENCES weather_observation(ob_id),
    CONSTRAINT fk_bike
        FOREIGN KEY(bike_id)
        REFERENCES bike(bike_id),
    CONSTRAINT fk_start_station
        FOREIGN KEY(station_id)
        REFERENCES bike_station(station_id),
    CONSTRAINT fk_end_station
        FOREIGN KEY(station_id)
        REFERENCES bike_station(station_id)
)
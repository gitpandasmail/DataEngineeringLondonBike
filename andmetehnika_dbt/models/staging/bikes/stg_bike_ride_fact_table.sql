select
  ob_id,
  date_id,
  time_id,
  start_station_id,
  end_station_id,
  ride_begin_time,
  ride_end_time,
  duration_time,
  duration_ms,
  bike_mode
from {{ source('bikes', 'bike_ride_fact_table') }}
select
  time_id,
  hour,
  minute,
  is_summer_time,
  time_of_day,
  is_peak,
  peak_type
from {{ source('bikes', 'dim_time') }}
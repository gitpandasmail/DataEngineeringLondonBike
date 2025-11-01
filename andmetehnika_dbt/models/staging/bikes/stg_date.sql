select
  date_id,
  day,
  week,
  month,
  year,
  day_of_week,
  is_weekend,
  season,
  is_holiday,
  holiday_name
from {{ source('bikes', 'dim_date') }}

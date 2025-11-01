select
  ob_id,
  ob_time,
  wind_direction,
  wind_speed_g,
  air_temperature_g,
  has_prcp,
  prcp_amt_g,
  prst_wx_id,
  cld_tlt_amt_id,
  cld_base_ht,
  ground_state_id
from {{ source('weather', 'dim_weather_observations') }}
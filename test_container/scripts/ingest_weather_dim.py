import requests
import pandas as pd
from clickhouse_connect import get_client
from datetime import datetime

API_KEY = "YOUR_OPENWEATHER_API_KEY"
CITY = "New York"

def ingest_weather_dim():
    url = f"http://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric"
    data = requests.get(url).json()
    df = pd.DataFrame([{
        "ob_id": int(datetime.utcnow().timestamp()),
        "ob_time": datetime.utcfromtimestamp(data["dt"]),
        "wind_direction": data["wind"].get("deg", 0),
        "wind_speed_g": data["wind"]["speed"],
        "air_temperature_g": data["main"]["temp"],
        "has_prcp": 1 if "rain" in data else 0,
        "prcp_amt_g": data.get("rain", {}).get("1h", 0.0),
        "prst_wx_id": 1,  # placeholder
        "cld_tlt_amt_id": 1,
        "cld_base_ht": 0.0,
        "ground_state_id": 1
    }])
    
    client = get_client(host="localhost", username="default", password="")
    client.insert_df("dim_weather_observations", df)
    print(f"Inserted {len(df)} weather rows")

if __name__ == "__main__":
    ingest_weather_dim()

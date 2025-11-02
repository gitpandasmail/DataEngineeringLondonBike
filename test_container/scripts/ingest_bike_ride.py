import pandas as pd
from datetime import datetime, timedelta
from clickhouse_connect import get_client
import random

def ingest_bike_ride_fact():
    now = datetime.utcnow()
    data = [{
        "ob_id": int(now.timestamp()),
        "date_id": int(now.strftime("%Y%m%d")),
        "time_id": int(now.strftime("%H%M")),
        "start_station_id": random.randint(1, 100),
        "end_station_id": random.randint(1, 100),
        "ride_begin_time": now - timedelta(minutes=random.randint(5, 60)),
        "ride_end_time": now,
        "duration_time": random.uniform(5.0, 60.0),
        "duration_ms": random.randint(300000, 3600000),
        "bike_mode": random.choice(["classic", "electric"])
    } for _ in range(10)]

    df = pd.DataFrame(data)
    client = get_client(host="localhost", username="default", password="")
    client.insert_df("bike_ride_fact_table", df)
    print(f"Inserted {len(df)} rides")

if __name__ == "__main__":
    ingest_bike_ride_fact()

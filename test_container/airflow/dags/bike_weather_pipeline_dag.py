from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime, timedelta
import pandas as pd
import os
import requests
import logging

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'bike_weather_pipeline',
    default_args=default_args,
    description='Simple bike and weather ETL pipeline',
    schedule_interval='@daily',
    catchup=False,
)

API_URL_VAR = "MOLES_API_URL"
TOKEN_VAR = "CEDA_API_TOKEN"

def setup_database():
    """Create tables if they don't exist"""
    pg_hook = PostgresHook(postgres_conn_id='postgres_default')
    
    sql = """
    CREATE TABLE IF NOT EXISTS bike_station (
        station_id VARCHAR(50) PRIMARY KEY,
        station_name VARCHAR(255)
    );
    
    CREATE TABLE IF NOT EXISTS bike (
        bike_id VARCHAR(50) PRIMARY KEY,
        bike_mode VARCHAR(50)
    );
    
    CREATE TABLE IF NOT EXISTS weather_observation (
        ob_id SERIAL PRIMARY KEY,
        ob_time TIMESTAMP UNIQUE,
        wind_speed FLOAT,
        wind_direction VARCHAR(10),
        air_temperature FLOAT,
        prcp_amt FLOAT
    );
    
    CREATE TABLE IF NOT EXISTS bike_ride (
        ride_id VARCHAR(50) PRIMARY KEY,
        begin_time TIMESTAMP,
        end_time TIMESTAMP,
        duration_ms BIGINT,
        station_id VARCHAR(50),
        bike_id VARCHAR(50)
    );
    """
    pg_hook.run(sql)
    logging.info("Database setup complete")



def fetch_weather_catalogue(search_term: str = "weather"):
    # 1. Get credentials from environment variables
    base_url = os.getenv(API_URL_VAR)
    token = os.getenv(TOKEN_VAR)
    
    if not base_url or not token:
        print(f"Error: Set environment variables {API_URL_VAR} (e.g., 'https://catalogue.ceda.ac.uk/api/v3/') and {TOKEN_VAR}.")
        return

    # The specific endpoint for listing datasets/catalogue items
    api_path = "api/v3/"
    endpoint = "datasets/"
    url = f"{base_url.rstrip('/')}/{api_path}{endpoint}"
    
    # Headers for authentication
    headers = {
        'Authorization': f'Bearer {token}',
        'Accept': 'application/json'
    }
    
    # Parameters for searching
    params = {'search': search_term}

    print(f"-> Requesting data from: {url}?search={search_term}")
    
    try:
        # 2. Make the API request
        response = requests.get(url, headers=headers, params=params, timeout=10)
        response.raise_for_status() # Check for bad status codes (4xx or 5xx)
        
        data = response.json()
        
        # 3. Process and display results
        count = data.get('count', 0)
        print(f"-> Success! Found {count} results for '{search_term}'.")
        
        if data.get('results'):
            print("\n--- Top 3 Results ---")
            for i, result in enumerate(data['results'][:3]):
                title = result.get('title', 'No Title')
                uuid = result.get('uuid', 'No UUID')
                print(f"  {i+1}. Title: {title}\n     UUID: {uuid}")
        
    except requests.exceptions.RequestException as e:
        print(f"\n-> An error occurred during the request: {e}")
        if 'response' in locals():
            print(f"   Status Code: {response.status_code}")
            
if __name__ == "__main__":
    fetch_weather_catalogue()

def load_csv_data():
    """Load bike data from CSV files"""
    pg_hook = PostgresHook(postgres_conn_id='postgres_default')
    conn = pg_hook.get_conn()
    
    # Load bike stations
    df_stations = pd.read_csv('/opt/airflow/data/bike_stations.csv')
    df_stations = df_stations.drop_duplicates(subset=['station_id'])  # Quality check: remove duplicates
    
    for _, row in df_stations.iterrows():
        pg_hook.run(
            "INSERT INTO bike_station VALUES (%s, %s) ON CONFLICT (station_id) DO NOTHING",
            parameters=(row['station_id'], row['station_name'])
        )
    
    # Load bikes
    df_bikes = pd.read_csv('/opt/airflow/data/bikes.csv')
    df_bikes = df_bikes.drop_duplicates(subset=['bike_id'])  # Quality check: remove duplicates
    
    for _, row in df_bikes.iterrows():
        pg_hook.run(
            "INSERT INTO bike VALUES (%s, %s) ON CONFLICT (bike_id) DO NOTHING",
            parameters=(row['bike_id'], row['bike_mode'])
        )
    
    # Load bike rides
    df_rides = pd.read_csv('/opt/airflow/data/bike_rides.csv')
    df_rides = df_rides.dropna(subset=['ride_id', 'begin_time', 'end_time'])  # Quality check: remove nulls
    df_rides = df_rides.drop_duplicates(subset=['ride_id'])  # Quality check: remove duplicates
    
    for _, row in df_rides.iterrows():
        pg_hook.run(
            "INSERT INTO bike_ride VALUES (%s, %s, %s, %s, %s, %s) ON CONFLICT (ride_id) DO NOTHING",
            parameters=(
                row['ride_id'], 
                row['begin_time'], 
                row['end_time'],
                row['duration_ms'],
                row['station_id'],
                row['bike_id']
            )
        )
    
    logging.info(f"Loaded {len(df_rides)} rides, {len(df_stations)} stations, {len(df_bikes)} bikes")

def load_weather_data(**context):
    """Fetch weather data from API"""
    pg_hook = PostgresHook(postgres_conn_id='postgres_default')
    execution_date = context['ds']
    
    # Mock API call - replace with actual CEDA API
    weather_data = [{
        'ob_time': f"{execution_date} 12:00:00",
        'wind_speed': 10.5,
        'wind_direction': 'N',
        'air_temperature': 15.2,
        'prcp_amt': 0.0
    }]
    
    for record in weather_data:
        # Quality check: validate temperature range
        if record['air_temperature'] < -50 or record['air_temperature'] > 60:
            logging.warning(f"Invalid temperature: {record['air_temperature']}")
            continue
        
        pg_hook.run(
            """INSERT INTO weather_observation (ob_time, wind_speed, wind_direction, air_temperature, prcp_amt)
               VALUES (%s, %s, %s, %s, %s) 
               ON CONFLICT (ob_time) DO NOTHING""",
            parameters=(
                record['ob_time'],
                record['wind_speed'],
                record['wind_direction'],
                record['air_temperature'],
                record['prcp_amt']
            )
        )
    
    logging.info(f"Loaded {len(weather_data)} weather observations")

# Define tasks
setup_task = PythonOperator(
    task_id='setup_database',
    python_callable=setup_database,
    dag=dag,
)

load_csv_task = PythonOperator(
    task_id='load_csv_data',
    python_callable=load_csv_data,
    dag=dag,
)

load_weather_task = PythonOperator(
    task_id='load_weather_data',
    python_callable=load_weather_data,
    dag=dag,
)

# Task order
setup_task >> [load_csv_task, load_weather_task]
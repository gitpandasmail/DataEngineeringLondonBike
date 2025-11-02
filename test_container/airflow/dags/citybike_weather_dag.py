from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

from scripts.ingest_weather_dim import ingest_weather_dim
from scripts.ingest_bike_ride import ingest_bike_ride_fact

default_args = {
    "owner": "data_team",
    "retries": 1,
    "retry_delay": timedelta(minutes=3),
}

with DAG(
    "citybike_weather_pipeline",
    default_args=default_args,
    description="Ingest CityBike and Weather data into ClickHouse and run dbt models",
    schedule_interval="@hourly",
    start_date=datetime(2025, 1, 1),
    catchup=False,
) as dag:

    ingest_weather = PythonOperator(
        task_id="ingest_weather_dim",
        python_callable=ingest_weather_dim
    )

    ingest_bike_ride = PythonOperator(
        task_id="ingest_bike_ride_fact",
        python_callable=ingest_bike_ride_fact
    )

    run_dbt = BashOperator(
        task_id="run_dbt_models",
        bash_command="cd /opt/dbt && dbt run --profiles-dir ."
    )

    [ingest_weather, ingest_bike_ride] >> run_dbt

from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['admin@admin.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
with DAG(
    'ingest_data',
    default_args=default_args,
    description='Run import.py to ingest data into PostgreSQL',
    schedule_interval='@daily',  # Runs every day at midnight
    start_date=datetime(2025, 10, 26),  # Change to your desired start date
    catchup=False,
    tags=['data_ingestion'],
) as dag:

    run_import_script = BashOperator(
        task_id='run_import_py',
        bash_command='python /opt/airflow/scripts/import.py',
    )

    run_import_script

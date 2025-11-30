

-- Create users first (before databases)
CREATE USER superset WITH PASSWORD 'superset';
CREATE USER airflow WITH PASSWORD 'airflow';
CREATE USER openmetadata WITH PASSWORD 'openmetadata';

-- Create databases for each service
CREATE DATABASE superset OWNER superset;
CREATE DATABASE airflow OWNER airflow;
CREATE DATABASE openmetadata OWNER openmetadata;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE superset TO superset;
GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
GRANT ALL PRIVILEGES ON DATABASE openmetadata TO openmetadata;

-- Connect to each database and grant schema privileges
\c superset
GRANT ALL ON SCHEMA public TO superset;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO superset;

\c airflow
GRANT ALL ON SCHEMA public TO airflow;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO airflow;

\c openmetadata
GRANT ALL ON SCHEMA public TO openmetadata;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO openmetadata;
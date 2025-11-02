### Instructions for Clickhouse

#### Docker
`compose.yml`
`Docker compose up`
#### Clickhouse table creation

Create the table: 
`docker exec -it clickhouse-server clickhouse-client --multiquery --queries-file=/sql/create_bike_db_and_tables.sql"`


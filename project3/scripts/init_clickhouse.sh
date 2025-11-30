#!/bin/bash
# Start ClickHouse server in background
clickhouse-server --daemon

# Wait a few seconds for server to start
sleep 5

# Run SQL files
clickhouse-client --multiquery < /sql/schema.sql

# Keep server running
tail -f /var/log/clickhouse-server/clickhouse-server.log

#!/bin/bash
set -e

# Start ClickHouse server in the background
clickhouse-server --daemon

# Wait for server to be ready
until clickhouse-client --query "SELECT 1" &>/dev/null; do
  echo "Waiting for ClickHouse to be ready..."
  sleep 2
done

echo "ClickHouse is ready, executing SQL files..."

# Ingest all SQL files in /sql
for f in /sql/*.sql; do
  echo "Running $f ..."
  clickhouse-client --multiquery --query="$(cat $f)"
done

# Keep the container running in foreground
clickhouse-server --foreground

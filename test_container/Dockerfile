# Use a lightweight Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DBT_PROFILES_DIR=/root/.dbt

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Install dbt-core and dbt-clickhouse
RUN pip install dbt-core dbt-clickhouse

# Set working directory
WORKDIR /app

# Copy your dbt project
COPY . /app

# Default command
ENTRYPOINT ["dbt"]

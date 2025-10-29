FROM clickhouse/clickhouse-server:latest

# install HTTP server and utilities
RUN apt-get update && apt-get install -y nginx curl && rm -rf /var/lib/apt/lists/*

# install Tabix UI from the image
RUN docker pull spoonest/clickhouse-tabix-web-client:latest \
    && docker create --name tmp tabix-temp-image spoonest/clickhouse-tabix-web-client:latest \
    && docker cp tmp:/usr/share/nginx/html /var/www/html/tabix \
    && docker rm tmp

# configure nginx to serve the UI and proxy to ClickHouse HTTP interface
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8123 9000 8080

CMD clickhouse-server --daemon && nginx -g "daemon off;"

import requests
import sqlite3

# --- Constants ---
API_URL = "https://randomuser.me/api/"
DB_NAME = "users.db"
TABLE_NAME = "users"

# --- Fetch Data from API ---
def fetch_user_data():
    response = requests.get(API_URL)
    response.raise_for_status()  # Raise an exception for HTTP errors
    data = response.json()
    return data["results"][0]  # Return the first user result

# --- Flatten the relevant fields ---
def flatten_user_data(user):
    flat_data = {}

    # Flatten 'name' fields
    name_fields = user.get("name", {})
    for key, value in name_fields.items():
        flat_data[f"name_{key}"] = value

    # Flatten 'location' fields
    location_fields = user.get("location", {})
    for key, value in location_fields.items():
        if isinstance(value, dict):
            for subkey, subvalue in value.items():
                flat_data[f"location_{key}_{subkey}"] = subvalue
        else:
            flat_data[f"location_{key}"] = value

    return flat_data

# --- Create Table If Not Exists ---
def create_users_table(conn, sample_data):
    columns = ', '.join([f"{col} TEXT" for col in sample_data.keys()])
    create_table_sql = f"""
    CREATE TABLE IF NOT EXISTS {TABLE_NAME} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        {columns}
    )
    """
    conn.execute(create_table_sql)
    conn.commit()

# --- Insert Data ---
def insert_user_data(conn, flat_data):
    columns = ', '.join(flat_data.keys())
    placeholders = ', '.join(['?' for _ in flat_data])
    values = list(flat_data.values())

    insert_sql = f"INSERT INTO {TABLE_NAME} ({columns}) VALUES ({placeholders})"
    conn.execute(insert_sql, values)
    conn.commit()

# --- Main Execution ---
def main():
    # Fetch and flatt
    user_data = fetch_user_data()
    flat_data = flatten_user_data(user_data)

    # Connect to SQLite and prepare table
    conn = sqlite3.connect(DB_NAME)
    create_users_table(conn, flat_data)

    # Insert data
    insert_user_data(conn, flat_data)

    # Done
    print(f"Inserted user data into '{TABLE_NAME}' table in '{DB_NAME}'")

    conn.close()

if __name__ == "__main__":
    main()

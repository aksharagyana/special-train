# If not already installed, install necessary libraries
# !pip install pandas googletrans==4.0.0-rc1 pyodbc


import pandas as pd
import pyodbc
from googletrans import Translator
import csv

# Connect to the SQL Server database
server = 'your_sql_server_name_or_ip'  # e.g., 'localhost'
database = 'your_database_name'  # Name of the database
username = 'your_username'  # Username for SQL Server
password = 'your_password'  # Password for SQL Server

# Set up the connection string
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# Establish the connection
conn = pyodbc.connect(connection_string)

# Get the list of tables
query = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'"
tables = pd.read_sql_query(query, conn)

# Initialize Google Translate
translator = Translator()

# Open CSV files for writing
with open("original_data_sqlserver.csv", "w", newline="", encoding="utf-8") as original_csvfile, \
     open("translated_data_sqlserver.csv", "w", newline="", encoding="utf-8") as translated_csvfile:

    original_writer = csv.writer(original_csvfile)
    translated_writer = csv.writer(translated_csvfile)

    for table in tables["TABLE_NAME"]:
        query = f"SELECT TOP 10 * FROM {table};"
        df = pd.read_sql_query(query, conn)

        # Write table name and column headers to the CSV files
        original_writer.writerow([f"Table: {table}"])
        original_writer.writerow(df.columns)

        translated_writer.writerow([f"Table: {table}"])
        translated_writer.writerow(df.columns)

        # Translate each row and write to the CSV files
        for _, row in df.iterrows():
            # Write the original row to the original data CSV
            original_writer.writerow(row.tolist())

            # Translate the row and write to the translated data CSV
            translated_row = []
            for col in row.index:
                if isinstance(row[col], str):
                    translated_text = translator.translate(row[col], dest='en').text
                else:
                    translated_text = row[col]  # No need to translate non-string data
                translated_row.append(translated_text)

            translated_writer.writerow(translated_row)

        # Add a blank row for separation between tables
        original_writer.writerow([])
        translated_writer.writerow([])

# Close the database connection
conn.close()

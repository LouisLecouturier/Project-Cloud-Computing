import os
from dotenv import load_dotenv
import psycopg2

load_dotenv()

class DatabaseConnection:
    def __init__(self):
        self.connection = psycopg2.connect(
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
        )

    def get_connection(self):
        return self.connection

    def get_cursor(self):
        return self.connection.cursor()

    def execute(self, query):
        with self.connection.cursor() as cursor:
            cursor.execute(query)
            self.connection.commit()
            
            return 

    def commit(self):
        self.connection.commit()

    def close_connection(self):
        self.connection.close()
        print("Connection closed.")

    def run_sql_file(self, file_path):
        """Exécute un fichier SQL sur la base de données"""
        with open(file_path, 'r') as file:
            sql = file.read()
        self.execute(sql)
        print(f"SQL script from {file_path} executed.")

import os

import psycopg2
from dotenv import load_dotenv

load_dotenv()


class DatabaseConnection:
    def __init__(self):
        self.connection = psycopg2.connect(
            dbname=os.getenv("DATABASE_NAME"),
            user=os.getenv("DATABASE_USER"),
            password=os.getenv("DATABASE_PASSWORD"),
            host=os.getenv("DATABASE_HOST"),
            port=os.getenv("DATABASE_PORT"),
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
        with open(file_path, "r") as file:
            sql = file.read()
        self.execute(sql)
        print(f"SQL script from {file_path} executed.")

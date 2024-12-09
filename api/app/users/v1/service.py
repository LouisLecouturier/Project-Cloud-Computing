from database.utils.db import DatabaseConnection

class UserService:
    def __init__(self):
        self.db_connection = DatabaseConnection()
        
        print("USER Service...")

    def get_user(self, id: int):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM users WHERE id = %s", (id,))
            user = cursor.fetchone()
        return {"user_id": id, "user": user}

    def get_all_users(self):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM users")
            users = cursor.fetchall()
        return {"users": users}

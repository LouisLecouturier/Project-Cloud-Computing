from database.utils.db import DatabaseConnection

class UserService:
    def __init__(self):
        self.db_connection = DatabaseConnection()
        
        print("USER Service...")

    def get_user(self, id: int):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM users WHERE id = %s", (id,))
            user = cursor.fetchone()
            
            response_data = {
                "id": user[0],
                "username": user[1],
                "email": user[2]
            }
        return response_data

    def get_all_users(self):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM users")
            users = cursor.fetchall()
            
            response_data = [
            {
                "Id": user[0],
                "Username": user[1],
                "Email": user[2]
            } for user in users
        ]
        return {"users": response_data}
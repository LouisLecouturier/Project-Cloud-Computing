from database.utils.db import DatabaseConnection

class BasketService:
    def __init__(self):
        self.db_connection = DatabaseConnection()

    def get_from_user(self, id: int):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM baskets WHERE user_id = %s", (id,))
            basket = cursor.fetchone()
        return {"user_id": id, "basket": basket}

    def get_all_baskets(self):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM baskets")
            baskets = cursor.fetchall()
        return {"baskets": baskets}

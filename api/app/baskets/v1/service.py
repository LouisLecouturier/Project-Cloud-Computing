from database.utils.db import DatabaseConnection

class BasketService:
    def __init__(self):
        self.db_connection = DatabaseConnection()

    def get_from_user(self, id: int):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM baskets WHERE user_id = %s", (id,))
            basket = cursor.fetchone()
            
            response_data = {
                "id": basket[0],
                "user_id": basket[1],
                "item_id": basket[2],
                "quantity": basket[3]
            }
        return response_data

    def get_all_baskets(self):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM baskets")
            baskets = cursor.fetchall()
            
            response_data = [
            {
                "Id": basket[0],
                "UserId": basket[1],
                "ItemId": basket[2],
                "Quantity": basket[3]
            } for basket in baskets
        ]
        return {"baskets": response_data}

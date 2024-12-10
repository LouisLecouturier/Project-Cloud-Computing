from database.utils.db import DatabaseConnection


class ItemService:
    def __init__(self):
        self.db_connection = DatabaseConnection()

        print("ITEMS Service...")

    def get_item(self, id: int):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM items WHERE id = %s", (id,))
            item = cursor.fetchone()

            response_data = {
                "id": item[0],
                "name": item[1],
                "description": item[2],
                "price": float(item[3]),
            }

        return response_data

    def get_all_items(self):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM items")
            items = cursor.fetchall()
            response_data = [
                {
                    "Id": item[0],
                    "Name": item[1],
                    "Description": item[2],
                    "Price": item[3],
                }
                for item in items
            ]

        return {"items": response_data}

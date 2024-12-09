from database.utils.db import DatabaseConnection

class ItemService:
    def __init__(self):
        self.db_connection = DatabaseConnection()
        
        print("ITEMS Service...")

    def get_item(self, id: int):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM items WHERE id = %s", (id,))
            item = cursor.fetchone()
        return {"user_id": id, "item": item}

    def get_all_items(self):
        with self.db_connection.get_cursor() as cursor:
            cursor.execute("SELECT * FROM items")
            items = cursor.fetchall()
        return {"items": items}

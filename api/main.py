from fastapi import FastAPI

from app.router import router

from database.utils.db import DatabaseConnection

app = FastAPI()

db_connection = DatabaseConnection()

app.include_router(router, prefix="/api")

@app.get("/")
def read_root():
    return {"message": "Hello World"}


if __name__ == "__main__":
    import uvicorn
    
    # Drop all the db (don't use in prod, only for demo)
    db_connection.execute(open("./database/scripts/clear.sql", "r").read())
    
    # Seed db
    db_connection.execute(open("./database/scripts/init.sql", "r").read())

    uvicorn.run(app, host="0.0.0.0", port=8000)

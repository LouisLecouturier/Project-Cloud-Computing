from fastapi import FastAPI

from app.router import router

from database import DatabaseConnection

app = FastAPI()

db_connection = DatabaseConnection()
db_connection.run_sql_file('database/scripts/init.sql')

app.include_router(router, prefix="/api")

@app.get("/")
def read_root():
    return {"message": "Hello World"}


if __name__ == "__main__":
    import uvicorn
    
    # Drop all the db (don't use in prod, only for demo)
    
    # Seed db

    uvicorn.run(app, host="0.0.0.0", port=8000)

from fastapi import FastAPI

from app.router import router

app = FastAPI()

app.include_router(router, prefix="/api")


if __name__ == "__main__":
    import uvicorn
    
    # Drop all the db (don't use in prod, only for demo)
    
    # Seed db

    uvicorn.run(app, host="0.0.0.0", port=8000)

from fastapi import APIRouter

from app.baskets.router import router as baskets_router
from app.items.router import router as items_router
from app.users.router import router as users_router
from database.utils.db import DatabaseConnection


router = APIRouter()
db_connection = DatabaseConnection()


router.include_router(users_router, tags=["users"])
router.include_router(items_router, tags=["items"])
router.include_router(baskets_router, tags=["baskets"])


@router.get("/")
async def read_root():
    return {"message": "Hello World"}

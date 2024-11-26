from fastapi import APIRouter

from app.users.v1.service import UserService

router = APIRouter(prefix="/users")

user_service = UserService()


@router.get("/")
async def get_all_users():
    return user_service.get_all_users()


@router.get("/{user_id}")
async def get_user(user_id: int):
    return user_service.get_user(user_id)

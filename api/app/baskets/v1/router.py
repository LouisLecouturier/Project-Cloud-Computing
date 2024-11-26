from fastapi import APIRouter

from app.baskets.v1.service import BasketService

router = APIRouter(prefix="/baskets")

basket_service = BasketService()


@router.get("/")
async def get_all_baskets():
    return basket_service.get_all_baskets()


@router.get("/user/{id}")
async def get_basket(id: int):
    return basket_service.get_from_user(id)

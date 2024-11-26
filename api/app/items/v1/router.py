from fastapi import APIRouter

from app.items.v1.service import ItemService

router = APIRouter(prefix="/items")

item_service = ItemService()


@router.get("/")
def get_all():
    return item_service.get_all_items()


@router.get("/{item_id}")
def get_one(item_id: int):
    return item_service.get_item(item_id)

from fastapi import APIRouter, Depends
from app.core.auth_dependency import get_current_user

router = APIRouter()

@router.get("/moods")
def get_moods(current_user=Depends(get_current_user)):
    return {
        "message": "Authenticated",
        "firebase_uid": current_user["uid"]
    }
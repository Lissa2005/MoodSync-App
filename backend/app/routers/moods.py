from fastapi import APIRouter, Depends
from app.api.deps import get_current_firebase_user

router = APIRouter()

@router.post("/moods")
async def save_mood(payload: dict, firebase_user: dict = Depends(get_current_firebase_user)):
    # This route is now protected! Only logged-in Firebase users can hit it.
    uid = firebase_user['uid']
    return {"message": f"Mood saved for user {uid}"}

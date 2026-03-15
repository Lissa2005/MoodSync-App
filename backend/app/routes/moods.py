from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.db.model.moods import Mood

router = APIRouter()

@router.post("/moods")
def add_mood(user_id: int, mood_label: str, db: Session = Depends(get_db)):

    new_mood = Mood(
        user_id=user_id,
        mood_label=mood_label
    )

    db.add(new_mood)
    db.commit()
    db.refresh(new_mood)

    return new_mood
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.model.activity import Activity

router = APIRouter()

@router.get("/activities/{mood}")
def get_activities(mood: str, db: Session = Depends(get_db)):
    activities = db.query(Activity).filter(Activity.mood_label == mood).all()
    return activities
from sqlalchemy.orm import Session
from app.models.activity import Activity
from app.schemas.activity import ActivityCreate, ActivityUpdate
import random


# Get all activities
def get_all_activities(db: Session):
    return db.query(Activity).all()


# Get activities by mood
def get_activities_by_mood(db: Session, mood: str):
    return db.query(Activity).filter(Activity.mood == mood).all()


# Get random activity by mood
def get_random_activity_by_mood(db: Session, mood: str):
    activities = db.query(Activity).filter(Activity.mood == mood).all()
    if activities:
        return random.choice(activities)
    return None


# Get activities by type (music, food, story, activity etc)
def get_activities_by_type(db: Session, activity_type: str):
    return db.query(Activity).filter(Activity.type == activity_type).all()


# Get activity by ID
def get_activity_by_id(db: Session, activity_id: int):
    return db.query(Activity).filter(Activity.id == activity_id).first()


# Create new activity
def create_activity(db: Session, activity: ActivityCreate):
    new_activity = Activity(**activity.dict())
    db.add(new_activity)
    db.commit()
    db.refresh(new_activity)
    return new_activity


# Update activity
def update_activity(db: Session, activity_id: int, activity: ActivityUpdate):
    db_activity = db.query(Activity).filter(Activity.id == activity_id).first()

    if not db_activity:
        return None

    for key, value in activity.dict(exclude_unset=True).items():
        setattr(db_activity, key, value)

    db.commit()
    db.refresh(db_activity)
    return db_activity


# Delete activity
def delete_activity(db: Session, activity_id: int):
    db_activity = db.query(Activity).filter(Activity.id == activity_id).first()

    if not db_activity:
        return None

    db.delete(db_activity)
    db.commit()
    return db_activity
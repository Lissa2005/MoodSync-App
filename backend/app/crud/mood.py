from sqlalchemy.orm import Session
from sqlalchemy import func
from app.models import moods
from app.schemas.mood import MoodCreate, MoodUpdate
from datetime import datetime, timedelta

# create mood entry
def create_mood(db: Session, mood: MoodCreate, user_id: int):
    db_mood = moods.Mood(
        user_id=user_id,
        mood_type=mood.mood_type,
        intensity=mood.intensity,
        note=mood.note,
        source=mood.source,
        created_at=datetime.utcnow()
    )
    db.add(db_mood)
    db.commit()
    db.refresh(db_mood)
    return db_mood

# get all mood entries for a user
def get_user_moods(db: Session, user_id: int, skip: int = 0, limit: int = 50):
    return db.query(moods.Mood)\
        .filter(moods.Mood.user_id == user_id)\
        .order_by(moods.Mood.created_at.desc())\
        .offset(skip)\
        .limit(limit)\
        .all()

# get mood entry by ID
def get_mood_by_id(db: Session, mood_id: int):
    return db.query(moods.Mood).filter(moods.Mood.id == mood_id).first()

# get recent mood entries for a user (last 7 days)
def get_recent_moods(db: Session, user_id: int, days: int = 7):
    cutoff_date = datetime.utcnow() - timedelta(days=days)
    return db.query(moods.Mood)\
        .filter(
            moods.Mood.user_id == user_id,
            moods.Mood.created_at >= cutoff_date
        )\
        .order_by(moods.Mood.created_at.desc())\
        .all()

# update mood entry
def update_mood(db: Session, mood_id: int, mood_update: MoodUpdate):
    db_mood = get_mood_by_id(db, mood_id)
    if db_mood:
        update_data = mood_update.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_mood, key, value)
        db.commit()
        db.refresh(db_mood)
    return db_mood

# delete mood entry
def delete_mood(db: Session, mood_id: int):
    db_mood = get_mood_by_id(db, mood_id)
    if db_mood:
        db.delete(db_mood)
        db.commit()
    return db_mood

# get mood statistics for a user (average intensity by mood)
def get_mood_statistics(db: Session, user_id: int, days: int = 30):
    cutoff_date = datetime.utcnow() - timedelta(days=days)
    stats = db.query(
        moods.Mood.mood_type,
        func.count(moods.Mood.mood_type).label('count')
    ).filter(
        moods.Mood.user_id == user_id,
        moods.Mood.created_at >= cutoff_date
    ).group_by(
        moods.Mood.mood_type
    ).all()
    
    result = {stat.mood_type: stat.count for stat in stats}
    all_moods = ['happy', 'sad', 'angry', 'calm', 'anxious', 'neutral', 'surprised', 'frustrated']
    for mood in all_moods:
        if mood not in result:
            result[mood] = 0
    return result

# get mood trend (average intensity over time)
def get_mood_trend(db: Session, user_id: int, days: int = 30):
    cutoff_date = datetime.utcnow() - timedelta(days=days)
    trends = db.query(
        func.date(moods.Mood.created_at).label('date'),
        func.avg(moods.Mood.intensity).label('avg_intensity')
    ).filter(
        moods.Mood.user_id == user_id,
        moods.Mood.created_at >= cutoff_date
    ).group_by(
        func.date(moods.Mood.created_at)
    ).order_by(
        func.date(moods.Mood.created_at)
    ).all()
    
    return [
        {"date": str(trend.date), "avg_intensity": float(trend.avg_intensity)}
        for trend in trends
    ]
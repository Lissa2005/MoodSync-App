from sqlalchemy import Column, Integer, Float, ForeignKey, Date
from app.db.base import Base

class MoodTrend(Base):
    __tablename__ = "mood_trends"

    trend_id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey("users.user_id"))

    average_mood = Column(Float)

    week_start = Column(Date)
    week_end = Column(Date)
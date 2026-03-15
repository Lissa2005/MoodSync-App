from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class MoodPrediction(Base):
    __tablename__ = "mood_predictions"

    prediction_id  = Column(Integer, primary_key=True)
    user_id        = Column(Integer, ForeignKey("users.user_id"))
    predicted_mood = Column(String(50))
    confidence     = Column(Float)
    predicted_at   = Column(TIMESTAMP(timezone=True), server_default=func.now())
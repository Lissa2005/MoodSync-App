from sqlalchemy import Column, Integer, String, Text, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class Mood(Base):
    __tablename__ = "moods"

    mood_id    = Column(Integer, primary_key=True)
    user_id    = Column(Integer, ForeignKey("users.user_id"))
    mood_label = Column(String(50))
    mood_note  = Column(Text)
    recorded_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
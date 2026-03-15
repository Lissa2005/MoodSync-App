from sqlalchemy import Column, Integer, String, Text
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class Activity(Base):
    __tablename__ = "activities"

    activity_id = Column(Integer, primary_key=True)

    mood_label = Column(String(50), nullable=False)

    title = Column(String(100))

    description = Column(Text)

    activity_type = Column(String(50))

    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
from sqlalchemy import Column, Integer, String, Text
from app.db.base import Base


class Activity(Base):

    __tablename__ = "activities"

    activity_id = Column(Integer, primary_key=True)

    mood_label = Column(String(50))

    recommendation = Column(Text)
    
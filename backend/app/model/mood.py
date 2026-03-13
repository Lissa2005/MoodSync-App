from sqlalchemy import Column, Integer, String, Text, ForeignKey, DateTime
from sqlalchemy.sql import func

class Mood(Base):
    __tablename__ = "moods"

    mood_id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete="CASCADE"))
    mood_label = Column(String(50))
    mood_note = Column(Text)
    recorded_at = Column(DateTime(timezone=True), server_default=func.now())
from sqlalchemy import Column, Integer, Text, String, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class CommunityStory(Base):
    __tablename__ = "community_stories"

    story_id       = Column(Integer, primary_key=True)
    user_id        = Column(Integer, ForeignKey("users.user_id"), nullable=True)
    anonymous_name = Column(String(50))
    content        = Column(Text)
    created_at     = Column(TIMESTAMP(timezone=True), server_default=func.now())
from sqlalchemy import Column, Integer, Text, String, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class StoryReply(Base):
    __tablename__ = "story_replies"

    reply_id = Column(Integer, primary_key=True)

    story_id = Column(Integer, ForeignKey("community_stories.story_id"))

    anonymous_name = Column(String(50))

    message = Column(Text)

    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
from sqlalchemy import Column, Integer, Text, Boolean, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class Notification(Base):
    __tablename__ = "notifications"

    notification_id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey("users.user_id"))

    message = Column(Text)

    is_read = Column(Boolean, default=False)

    sent_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
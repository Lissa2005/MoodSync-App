from sqlalchemy import Column, Integer, Boolean, String, ForeignKey
from app.db.base import Base

class UserSettings(Base):
    __tablename__ = "user_settings"

    setting_id             = Column(Integer, primary_key=True)
    user_id                = Column(Integer, ForeignKey("users.user_id"), unique=True)
    notifications_enabled  = Column(Boolean, default=True)
    theme                  = Column(String(20), default="light")
    language               = Column(String(20), default="en")
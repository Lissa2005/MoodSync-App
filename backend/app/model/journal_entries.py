from sqlalchemy import Column, Integer, Text, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.types import TIMESTAMP
from app.db.base import Base

class JournalEntry(Base):
    __tablename__ = "journal_entries"

    entry_id   = Column(Integer, primary_key=True)
    user_id    = Column(Integer, ForeignKey("users.user_id"))
    content    = Column(Text)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
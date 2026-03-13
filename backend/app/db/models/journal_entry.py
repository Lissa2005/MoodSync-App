from sqlalchemy import Column, Integer, Text, TIMESTAMP, ForeignKey
from sqlalchemy.sql import func
from app.db.base import Base


class JournalEntry(Base):

    __tablename__ = "journal_entries"

    entry_id = Column(Integer, primary_key=True)

    user_id = Column(Integer, ForeignKey("users.user_id"))

    content = Column(Text)

    created_at = Column(
        TIMESTAMP,
        server_default=func.now()
    )
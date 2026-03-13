from sqlalchemy import Column, Integer, String, Text, TIMESTAMP
from sqlalchemy.sql import func
from app.db.base import Base


class User(Base):

    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True)

    first_name = Column(String(50))
    last_name = Column(String(50))

    username = Column(String(50), unique=True)
    email = Column(String(100), unique=True)

    age = Column(Integer)

    password_hash = Column(Text)

    created_at = Column(
        TIMESTAMP,
        server_default=func.now()
    )
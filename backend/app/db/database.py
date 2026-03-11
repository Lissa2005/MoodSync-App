# database.py
# This connects FastAPI to PostgreSQL

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

DATABASE_URL = "postgresql://postgres:password@localhost/moodsync"

# Create database engine
engine = create_engine(DATABASE_URL)

# Session object used to talk to DB
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

# Base class for models
Base = declarative_base()
from typing import Generator  # <--- Add this import
from sqlalchemy import create_engine
from typing import Generator
from sqlalchemy.orm import sessionmaker, Session
from app.core.config import settings

engine = create_engine(settings.DATABASE_URL)

SessionLocal = sessionmaker(
    autoflush=False, 
    bind=engine
)

# Change 'Session' to 'Generator[Session, None, None]'
def get_db() -> Generator[Session, None, None]:
    """
    Creates a new SQLAlchemy session for a single request.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

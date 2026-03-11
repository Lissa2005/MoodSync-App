from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session # Added Session for type hinting
from app.core.config import settings

# Create the database engine
engine = create_engine(settings.DATABASE_URL)

# Create a session factory
SessionLocal = sessionmaker(
    # Removed autocommit=False (not needed in 2.0)
    autoflush=False, 
    bind=engine
)

# Dependency to get a database session
def get_db() -> Session:
    """
    Creates a new SQLAlchemy session for a single request and 
    ensures it is closed after the request is finished.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

from fastapi import FastAPI
import firebase_admin
from firebase_admin import credentials
from app.core.config import settings
from app.core.logger_setup import get_logger

# --- DATABASE IMPORTS ---
from app.db.session import engine
from app.db.base import Base
# ------------------------

# Create logger
logger = get_logger(__name__)

# Create FastAPI app
app = FastAPI(title=settings.APP_NAME)


@app.on_event("startup")
async def startup_event():
    logger.info(f"Starting {settings.APP_NAME} in {settings.ENVIRONMENT} mode")

    # Create database tables
    try:
        Base.metadata.create_all(bind=engine)
        logger.info("Database tables verified/created successfully.")
    except Exception as e:
        logger.error(f"Database connection failed: {e}")

    # 2. --- FIREBASE INITIALIZATION (Auth) ---
    try:
        # Check if already initialized to avoid errors during reloads
        if not firebase_admin._apps:
            # We use settings from your config.py which reads from .env
            cred = credentials.Certificate({
                "project_id": settings.FIREBASE_PROJECT_ID,
                "client_email": settings.FIREBASE_CLIENT_EMAIL,
                "private_key": settings.FIREBASE_PRIVATE_KEY.replace('\\n', '\n') if settings.FIREBASE_PRIVATE_KEY else None,
            })
            firebase_admin.initialize_app(cred)
            logger.info("Firebase Admin SDK initialized successfully.")
    except Exception as e:
        logger.error(f"Firebase initialization failed: {e}")

@app.get("/config-test")
def config_test():
    logger.debug("Config test endpoint was called")
    return {
        "environment": settings.ENVIRONMENT,
        "algorithm": settings.ALGORITHM
    }


@app.get("/")
def root():
    return {"message": "Welcome to MoodSync API"}
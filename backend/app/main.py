from fastapi import FastAPI
from app.core.config import settings
from app.core.logger_setup import get_logger  # Fix: Direct import from app.core

# Initialize the logger for this file
logger = get_logger(__name__)

app = FastAPI(title=settings.PROJECT_NAME)

@app.on_event("startup")
async def startup_event():
    logger.info(f"Starting {settings.PROJECT_NAME} in {settings.ENVIRONMENT} mode")

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

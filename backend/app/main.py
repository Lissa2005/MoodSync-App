from fastapi import FastAPI
from app.core.config import settings
from app.core import logging

app = FastAPI(title=settings.PROJECT_NAME)


@app.get("/config-test")
def config_test():
    return {
        "environment": settings.ENVIRONMENT,
        "algorithm": settings.ALGORITHM
    }
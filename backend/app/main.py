from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine
from dotenv import load_dotenv
from datetime import datetime
import os

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
engine = create_engine(DATABASE_URL, pool_pre_ping=True)

app = FastAPI(title="MoodSync API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

from app.routes import activities, moods

app.include_router(activities.router)
app.include_router(moods.router)

@app.on_event("startup")
def startup():
    try:
        with engine.connect() as connection:
            print("Database connection successful!")
    except Exception as e:
        print("Failed to connect to database:")
        print(e)

@app.get("/")
def root():
    return {"message": "MoodSync backend running"}

@app.get("/health")
def health():
    return {"status": "healthy", "time": datetime.now().isoformat()}
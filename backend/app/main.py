from fastapi import FastAPI
from sqlalchemy import create_engine
from dotenv import load_dotenv
from app.routes import activities
import os

# LOAD ENVIRONMENT VARIABLES
load_dotenv()

# DATABASE CONFIGURATION
DATABASE_URL = os.getenv("DATABASE_URL")

#create fastapi app
app = FastAPI(title="MoodSync API")
# Create SQLAlchemy engine
engine = create_engine(DATABASE_URL)

# STARTUP EVENT
@app.on_event("startup")
def startup():
    # TEST DATABASE CONNECTION
    try:
        with engine.connect() as connection:
            print("Database connection successful!")
    except Exception as e:
        print("Failed to connect to database:")
        print(e)

# TEST ROUTE
@app.get("/")
def root():
    return {"message": "MoodSync backend running"}
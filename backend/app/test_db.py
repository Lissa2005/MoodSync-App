# backend/app/test_db.py
import os
import pytest
from dotenv import load_dotenv

load_dotenv()

def test_database_connection():
    url = os.getenv("DATABASE_URL")
    if not url:
        pytest.skip("DATABASE_URL not set — skipping in CI")

    from sqlalchemy import create_engine, text
    engine = create_engine(url)
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 1"))
        assert result is not None

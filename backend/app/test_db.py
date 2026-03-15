import os
import pytest
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

@pytest.mark.skipif(
    os.getenv("CI") == "true",
    reason="skipping live DB tests in CI environment"
)

def test_supabase_connection():
    engine = create_engine(os.getenv("DATABASE_URL"))
    with engine.connect() as conn:
        print("Connected to Supabase successfully")
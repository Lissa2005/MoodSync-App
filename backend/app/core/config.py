from functools import lru_cache
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    # Database (Matches DATABASE_URL in .env)
    DATABASE_URL: str

    # Security (Updated to match JWT_SECRET in .env)
    JWT_SECRET: str 
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    # App (Matches APP_NAME and APP_ENV in .env)
    APP_NAME: str = "MoodSync Backend"
    APP_ENV: str = "development"

    model_config = SettingsConfigDict(
        env_file=".env",
        case_sensitive=True,
        extra="ignore"
    )

    @property
    def is_production(self) -> bool:
        return self.APP_ENV.lower() == "production"

@lru_cache()
def get_settings():
    return Settings()

settings = get_settings()

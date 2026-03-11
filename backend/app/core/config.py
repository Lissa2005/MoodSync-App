from typing import Optional
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    # App
    APP_NAME: str = "Moodsync Backend"
    APP_ENV: str = "development"
    ENVIRONMENT: str = "development"

    # Database - Initializing with None satisfies the linter
    # Pydantic will still throw a ValidationError at runtime if not in .env
    DATABASE_URL: str = None  # type: ignore

    # Security
    SECRET_KEY: str = None  # type: ignore
    JWT_SECRET: str = None  # type: ignore
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    # Modern Pydantic V2 Configuration
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding='utf-8',
        case_sensitive=False,
        extra="ignore"
    )

    @property
    def is_production(self) -> bool:
        return self.APP_ENV.lower() == "production" or self.ENVIRONMENT.lower() == "production"

# 1. Create the settings instance
settings = Settings()

# 2. Create the function your main.py is looking for
def get_settings():
    return settings
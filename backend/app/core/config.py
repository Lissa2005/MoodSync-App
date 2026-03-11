class Settings(BaseSettings):
    # App
    APP_NAME: str = "Moodsync Backend"
    APP_ENV: str = "development"
    ENVIRONMENT: str = "development"  # <--- ADD THIS LINE

    # Database
    DATABASE_URL: str

    # Security
    SECRET_KEY: str
    JWT_SECRET: str 
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
        # Check both just to be safe
        return self.APP_ENV.lower() == "production" or self.ENVIRONMENT.lower() == "production"

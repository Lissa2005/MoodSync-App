import logging
from app.core.config import settings

LOG_LEVEL = logging.INFO if settings.ENVIRONMENT == "production" else logging.DEBUG

logging.basicConfig(
    level=LOG_LEVEL,
    format="%(asctime)s - %(levelname)s - %(message)s",
)
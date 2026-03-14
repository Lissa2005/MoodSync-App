import logging
from app.core.config import get_settings


def get_logger(name: str):
    """
    Creates and returns a configured logger
    """
    settings = get_settings()

    log_level = logging.INFO if settings.ENVIRONMENT == "production" else logging.DEBUG

    logging.basicConfig(
        level=log_level,
        format="%(asctime)s - %(levelname)s - %(message)s",
        force=True
    )

    return logging.getLogger(name)
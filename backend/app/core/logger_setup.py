import logging
# We import the get_settings function instead of the 'settings' instance
# to avoid loading everything at the top level
from app.core.config import get_settings

def setup_logging():
    settings = get_settings()
    
    log_level = logging.INFO if settings.ENVIRONMENT == "production" else logging.DEBUG

    logging.basicConfig(
        level=log_level,
        format="%(asctime)s - %(levelname)s - %(message)s",
        force=True # Ensures it overrides any previous config
    )
    return logging.getLogger(__name__)

# Initialize it
logger = setup_logging()

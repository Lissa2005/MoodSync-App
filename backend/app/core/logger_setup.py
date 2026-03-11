import logging
from app.core.config import settings

# Determine log level based on environment
LOG_LEVEL = logging.INFO if settings.ENVIRONMENT == "production" else logging.DEBUG

def setup_logging():
    """
    Initializes the global logging configuration.
    """
    logging.basicConfig(
        level=LOG_LEVEL,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler()  # Outputs to terminal
        ]
    )

def get_logger(name: str):
    """
    Returns a logger instance for a specific module.
    """
    return logging.getLogger(name)

# Initialize when this module is imported
setup_logging()

import firebase_admin
from firebase_admin import credentials, auth
import os
import logging

logger = logging.getLogger(__name__)

BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))

SERVICE_ACCOUNT_PATH = os.path.join(
    BASE_DIR,
    "firebase",
    "service-account.json"
)

if not firebase_admin._apps:
    cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
    firebase_admin.initialize_app(cred)


def verify_firebase_token(id_token: str):
    try:
        decoded_token = auth.verify_id_token(id_token)

        return {
            "uid": decoded_token.get("uid"),
            "email": decoded_token.get("email")
        }

    except Exception as e:
        logger.error(f"Firebase Token Error: {e}")
        return None
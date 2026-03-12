import firebase_admin
from firebase_admin import credentials, auth
import os
import logging

logger = logging.getLogger(__name__)

SERVICE_ACCOUNT_PATH = os.getenv(
    "FIREBASE_CREDENTIALS",
    "service-account.json"
)

if not firebase_admin._apps:
    cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
    firebase_admin.initialize_app(cred)


def verify_firebase_token(id_token: str):
    """Verify Firebase ID token sent by the client."""
    try:
        decoded_token = auth.verify_id_token(id_token)
        return decoded_token
    except Exception as e:
        logger.error(f"Firebase Token Error: {e}")
        return None
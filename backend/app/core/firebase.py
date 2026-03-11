import firebase_admin
from firebase_admin import credentials, messaging, auth
import os

# Path to the JSON file you downloaded from Firebase Console
# Make sure this matches your actual filename in the root folder
SERVICE_ACCOUNT_PATH = "service-account.json"

if not firebase_admin._apps:
    cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
    firebase_admin.initialize_app(cred)

def verify_firebase_token(id_token: str):
    """Verifies a token sent from the Flutter app."""
    try:
        decoded_token = auth.verify_id_token(id_token)
        return decoded_token
    except Exception as e:
        print(f"Firebase Token Error: {e}")
        return None

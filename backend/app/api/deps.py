from fastapi import Header, HTTPException, Depends
from app.core.firebase import verify_firebase_token

async def get_current_firebase_user(authorization: str = Header(None)):
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing or invalid token")
    
    token = authorization.split("Bearer ")[1]
    user = verify_firebase_token(token)
    
    if not user:
        raise HTTPException(status_code=401, detail="Invalid Firebase Credentials")
    
    return user # Returns the dict with 'uid', 'email', etc.

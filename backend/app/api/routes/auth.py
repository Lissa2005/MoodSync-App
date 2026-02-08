from fastapi import APIRouter
from app.core.security import get_password_hash, create_access_token

router = APIRouter(prefix="/auth", tags=["Auth"])

@router.post("/login")
def login():
    return {"message": "Login endpoint ready"}

@router.post("/register")
def register():
    return {"message": "Register endpoint ready"}

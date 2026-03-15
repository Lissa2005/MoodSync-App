from pydantic import BaseModel, EmailStr
from uuid import UUID
from datetime import datetime
from typing import Optional

class UserBase(BaseModel):
    email: EmailStr
    username: Optional[str] = None
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    age: Optional[int] = None

class UserCreate(UserBase):
    auth_id: UUID

class UserResponse(UserBase):
    user_id: int
    auth_id: UUID
    created_at: datetime

    class Config:
        from_attributes = True
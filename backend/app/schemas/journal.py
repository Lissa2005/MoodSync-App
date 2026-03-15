from pydantic import BaseModel
from datetime import datetime

class JournalBase(BaseModel):
    content: str

class JournalCreate(JournalBase):
    user_id: int

class JournalResponse(JournalBase):
    entry_id: int
    user_id: int
    created_at: datetime

    class Config:
        from_attributes = True
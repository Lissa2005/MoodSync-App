from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class MoodBase(BaseModel):
    mood_label: str
    mood_note: Optional[str] = None

class MoodCreate(MoodBase):
    user_id: int

class MoodResponse(MoodBase):
    mood_id: int
    user_id: int
    recorded_at: datetime

    class Config:
        from_attributes = True
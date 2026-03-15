from pydantic import BaseModel
from typing import Optional

class ActivityBase(BaseModel):
    mood_label:    str
    title:         str
    description:   Optional[str] = None
    activity_type: str

class ActivityResponse(ActivityBase):
    activity_id: int

    class Config:
        from_attributes = True
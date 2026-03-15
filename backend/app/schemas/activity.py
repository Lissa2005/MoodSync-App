from pydantic import BaseModel
from typing import Optional

class ActivityBase(BaseModel):
    mood_label: str
    title: str
    description: Optional[str] = None
    activity_type: str

# Used when creating an activity
class ActivityCreate(ActivityBase):
    pass


# Used when updating an activity
class ActivityUpdate(BaseModel):
    mood_label: Optional[str] = None
    title: Optional[str] = None
    description: Optional[str] = None
    activity_type: Optional[str] = None


class ActivityResponse(ActivityBase):
    activity_id: int

    class Config:
        from_attributes = True
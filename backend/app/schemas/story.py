from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List

class StoryBase(BaseModel):
    anonymous_name: str
    content: str

class StoryCreate(StoryBase):
    user_id: Optional[int] = None

class StoryResponse(StoryBase):
    story_id: int
    user_id: Optional[int]
    created_at: datetime

    class Config:
        from_attributes = True

class ReplyBase(BaseModel):
    anonymous_name: str
    message: str

class ReplyCreate(ReplyBase):
    story_id: int

class ReplyResponse(ReplyBase):
    reply_id: int
    story_id: int
    created_at: datetime

    class Config:
        from_attributes = True
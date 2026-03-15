from sqlalchemy.orm import Session
from app.models import users
from app.schemas.user import UserCreate, UserUpdate

# get user by ID
def get_user_by_id(db: Session, user_id: int):
    return db.query(users.User).filter(users.User.id == user_id).first()

# get user by auth ID (superbase)
def get_user_by_auth_id(db: Session, auth_id: str):
    return db.query(users.User).filter(users.User.auth_id == auth_id).first()

# get user by email
def get_user_by_email(db: Session, email: str):
    return db.query(users.User).filter(users.User.email == email).first()

# get all users with pagination
def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(users.User).offset(skip).limit(limit).all()

# create a new user
def create_user(db: Session, user: UserCreate):
    db_user = users.User(
        email=user.email,
        username=user.username,
        full_name=user.full_name,
        auth_id=user.auth_id,
        profile_pic=user.profile_pic,
        bio=user.bio
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# update an existing user
def update_user(db: Session, user_id: int, user_update: UserUpdate):
    db_user = get_user_by_id(db, user_id)
    if db_user:
        update_data = user_update.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_user, key, value)
        db.commit()
        db.refresh(db_user)
    return db_user

# delete a user
def delete_user(db: Session, user_id: int):
    db_user = get_user_by_id(db, user_id)
    if db_user:
        db.delete(db_user)
        db.commit()
    return db_user

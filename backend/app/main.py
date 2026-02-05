from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="MoodSync API",
    description="AI-powered mood detection backend",
    version="1.0.0"
)

# CORS setup (Flutter + Web + ML access)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"status": "MoodSync backend running 🚀"}

@app.get("/health")
def health_check():
    return {"status": "ok"}

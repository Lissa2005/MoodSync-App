import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
import joblib
import os

print("TRAINING SPEECH EMOTION MODEL")
print("=" * 40)

# 1. Create synthetic speech features
n_samples = 1000
n_features = 20

np.random.seed(42)
X = np.random.randn(n_samples, n_features)
y = np.random.choice(['happy', 'sad', 'angry', 'neutral'], n_samples)

# 2. Train model
model = RandomForestClassifier(n_estimators=100)
model.fit(X, y)
print(f"Model trained! Features: {n_features}, Samples: {n_samples}")

# 3. Save model
os.makedirs("models", exist_ok=True)
joblib.dump(model, "models/speech_model_trained.pkl")

print(f"Model saved: models/speech_model_trained.pkl")
print("This is a placeholder.Will replace with real audio features and model soon ")
print("=" * 40)
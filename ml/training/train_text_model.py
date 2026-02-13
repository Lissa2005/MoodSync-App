import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
import joblib
import os

print("TRAINING TEXT EMOTION MODEL")
print("=" * 40)

# 1. Load data 
df = pd.read_csv("outputs/cleaned_text.csv")
print(f"Loaded {len(df)} text samples")

# 2. Take subset for faster training
df = df.head(5000)
print(f"Using {len(df)} samples for training")

# 3. Convert text to numbers
vectorizer = TfidfVectorizer(max_features=2000)
X = vectorizer.fit_transform(df['text'])
y = df['labels']

# 4. Train model
model = LogisticRegression(max_iter=1000)
model.fit(X, y)
print(f"Model trained! Accuracy: {model.score(X, y):.2%}")

# 5. Save model
os.makedirs("models", exist_ok=True)
joblib.dump(model, "models/text_model_trained.pkl")
joblib.dump(vectorizer, "models/text_vectorizer_trained.pkl")

print(f"Model saved: models/text_model_trained.pkl")
print("=" * 40)
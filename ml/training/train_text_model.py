import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, accuracy_score
import joblib
import os

print("TRAINING TEXT EMOTION MODEL (WITH VALIDATION)")
print("=" * 50)

# Load cleaned dataset
df = pd.read_csv("outputs/cleaned_text.csv")
print(f"Loaded {len(df)} text samples")

# Split into features and labels
X_text = df['text']
y = df['emotion']

# Train/Test split (80/20)
X_train, X_test, y_train, y_test = train_test_split(
    X_text, y, test_size=0.2, random_state=42
)

print(f"Training samples: {len(X_train)}")
print(f"Testing samples: {len(X_test)}")

# Convert text → TF-IDF vectors
vectorizer = TfidfVectorizer(max_features=2000)

X_train_vec = vectorizer.fit_transform(X_train)
X_test_vec = vectorizer.transform(X_test)

# Train Logistic Regression
model = LogisticRegression(max_iter=1000)
model.fit(X_train_vec, y_train)

# Validate on test data
y_pred = model.predict(X_test_vec)

accuracy = accuracy_score(y_test, y_pred)

print("\n📊 VALIDATION RESULTS")
print("=" * 50)
print(f"Validation Accuracy: {accuracy:.2%}")
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# Save trained model
os.makedirs("models", exist_ok=True)
joblib.dump(model, "models/text_model_trained.pkl")
joblib.dump(vectorizer, "models/text_vectorizer_trained.pkl")

print("\n✅ Model saved successfully!")
print("=" * 50)

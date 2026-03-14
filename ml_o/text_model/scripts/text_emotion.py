import pandas as pd
import joblib
import os
import json

print("TEXT EMOTION DETECTION USING ML MODEL")
print("=" * 40)

# ---------- Load trained model and vectorizer ----------
model_path = "models/text_model_trained.pkl"
vectorizer_path = "models/text_vectorizer_trained.pkl"

if not os.path.exists(model_path) or not os.path.exists(vectorizer_path):
    print("❌ Trained model or vectorizer not found. Please train the model first!")
    exit(1)

model = joblib.load(model_path)
vectorizer = joblib.load(vectorizer_path)

print("✅ Model and vectorizer loaded successfully")

# ---------- Function to predict emotion ----------
def predict_emotion(text):
    """
    Input: text string
    Output: (predicted_emotion, confidence)
    """
    X = vectorizer.transform([text])
    predicted_emotion = model.predict(X)[0]

    # Confidence: probability of predicted class
    probs = model.predict_proba(X)[0]
    class_index = list(model.classes_).index(predicted_emotion)
    confidence = probs[class_index]

    return predicted_emotion, confidence

# ---------- Test cases ----------
test_texts = [
    "I am so happy today!",
    "This makes me feel sad and disappointed",
    "I am angry about what happened",
    "I feel calm and peaceful right now",
    "I'm surprised by this news!"
]

results = []
for text in test_texts:
    emotion, confidence = predict_emotion(text)
    results.append({
        "text": text,
        "emotion": emotion,
        "confidence": round(confidence, 2)
    })
    print(f"\n'{text}'")
    print(f"Emotion: {emotion.upper()}")
    print(f"Confidence: {confidence:.1%}")

# ---------- Save results ----------
if not os.path.exists("outputs"):
    os.makedirs("outputs")

output_path = "outputs/text_emotion_results.json"
with open(output_path, "w") as f:
    json.dump(results, f, indent=2)

print(f"\n✅ Prediction results saved to {output_path}")
print("=" * 40)

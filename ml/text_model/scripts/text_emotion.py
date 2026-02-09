print("TEXT EMOTION DETECTION")
print("=" * 40)

def detect_emotion_simple(text):
    """Simple rule-based emotion detection for Week 2"""
    text_lower = text.lower()
    
    emotion_keywords = {
        'joy': ['happy', 'joy', 'excited', 'good', 'great', 'awesome', 'love'],
        'sadness': ['sad', 'unhappy', 'depressed', 'bad', 'worried', 'upset'],
        'anger': ['angry', 'mad', 'furious', 'annoyed', 'hate'],
        'calm': ['calm', 'peaceful', 'relaxed', 'chill', 'quiet'],
        'surprise': ['surprised', 'wow', 'amazing', 'unexpected']
    }
    
    for emotion, keywords in emotion_keywords.items():
        for keyword in keywords:
            if keyword in text_lower:
                confidence = 0.85 + (len(keyword) * 0.01)  # Simple confidence calculation
                return emotion, min(confidence, 0.95)
    
    return "neutral", 0.70

# Test cases
test_texts = [
    "I am so happy today!",
    "This makes me feel sad and disappointed",
    "I am angry about what happened",
    "I feel calm and peaceful right now",
    "I'm surprised by this news!"
]

print("Testing emotion detection:")
print("-" * 30)

import json
import os

results = []
for text in test_texts:
    emotion, confidence = detect_emotion_simple(text)
    results.append({
        "text": text,
        "emotion": emotion,
        "confidence": confidence
    })
    
    print(f"\n '{text}'")
    print(f"Emotion: {emotion.upper()}")
    print(f"Confidence: {confidence:.1%}")

# Save results
os.makedirs("../../outputs", exist_ok=True)
with open("../../outputs/text_emotion_results.json", "w") as f:
    json.dump(results, f, indent=2)

print("\n" + "=" * 40)
print("TEXT EMOTION DETECTOR WORKING!")
print("Results saved: outputs/text_emotion_results.json")
print("Note: Using simple rule-based detection for Week 2")
print("Will upgrade to BERT model in production")
print("=" * 40)
import json
import os
import random

print("SPEECH EMOTION DETECTION")

# Simulated model
emotions = ['happy', 'sad', 'angry', 'neutral']
audio_file = "sample_voice.wav"

# Simulate prediction
predicted_emotion = random.choice(emotions)
confidence = random.uniform(0.7, 0.95)

print(f"Audio file: {audio_file}")
print(f"Predicted emotion: {predicted_emotion}")
print(f"Confidence: {confidence:.1%}")

# Save result
os.makedirs("../../outputs", exist_ok=True)
with open("../../outputs/speech_test.json", "w") as f:
    json.dump({"file": audio_file, "emotion": predicted_emotion, "confidence": confidence}, f)

print("Speech model structure ready!")
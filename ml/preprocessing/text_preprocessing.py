import pandas as pd
import os

print("TEXT DATA PREPROCESSING")
print("=" * 40)

# ---------- Load GoEmotions train dataset ----------
dataset_path = "./datasets/goemotions/train.tsv"
df = pd.read_csv(dataset_path, sep="\t", header=None)
print(f"Loaded {len(df)} rows from {dataset_path}")

# ---------- Name columns ----------
df.columns = ["text", "labels", "id"]

# Remove empty text rows
df = df.dropna(subset=["text"])
print(f"After removing empty rows: {len(df)} samples")

# ---------- Define ID → Emotion mapping ----------
emotion_list = [
    "admiration", "amusement", "anger", "annoyance", "approval",
    "caring", "confusion", "curiosity", "desire", "disappointment",
    "disapproval", "disgust", "embarrassment", "excitement",
    "fear", "gratitude", "grief", "joy", "love", "nervousness",
    "optimism", "pride", "realization", "relief", "remorse",
    "sadness", "surprise", "neutral"
]

# Allowed emotions for this project
allowed_emotions = ["joy", "sadness", "anger", "surprise", "calm", "neutral"]

# Map numeric ID to project emotion
def map_label(label):
    # Split multi-labels, take first
    first_id = int(str(label).split(",")[0])
    emotion_name = emotion_list[first_id]
    
    # Map 'relief' → 'calm'
    if emotion_name == "relief":
        emotion_name = "calm"
    
    # Keep only allowed emotions
    if emotion_name in allowed_emotions:
        return emotion_name
    else:
        return None

# Apply mapping
df["emotion"] = df["labels"].apply(map_label)

# Remove rows that were not in allowed_emotions
df = df.dropna(subset=["emotion"])

# Keep only required columns
df = df[["text", "emotion"]]

# ---------- Save cleaned dataset ----------
os.makedirs("outputs", exist_ok=True)
output_path = "outputs/cleaned_text.csv"
df.to_csv(output_path, index=False)

print(f"✅ Text preprocessing done! Cleaned data saved to {output_path}")
print(f"Number of samples after filtering: {len(df)}")
print("=" * 40)

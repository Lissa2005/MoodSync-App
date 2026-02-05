import os
import pandas as pd

base_path = "../datasets/ravdess/Audio_Speech_Actors_01-24"
data = []

emotion_map = {
    "01": "neutral",
    "02": "calm",
    "03": "happy",
    "04": "sad",
    "05": "angry",
    "06": "fearful",
    "07": "disgust",
    "08": "surprised"
}

for actor in os.listdir(base_path):
    actor_path = os.path.join(base_path, actor)
    if os.path.isdir(actor_path):
        for file in os.listdir(actor_path):
            emotion_code = file.split("-")[2]
            emotion = emotion_map[emotion_code]

            data.append({
                "file": file,
                "emotion": emotion
            })

df = pd.DataFrame(data)
df.to_csv("../outputs/audio_metadata.csv", index=False)

print("✅ Audio preprocessing done!")
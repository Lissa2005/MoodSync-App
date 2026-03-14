import os
import pandas as pd

RAVDESS_PATH = "dataset/speech_emotion/RAVDESS"

emotion_map = {
    "01": "Neutral",
    "02": "Calm",
    "03": "Happy",
    "04": "Sad",
    "05": "Angry",
    "06": "Anxious",
    "07": "Frustrated",
    "08": "Surprised"
}


def load_ravdess():

    data = []

    for actor in os.listdir(RAVDESS_PATH):

        actor_path = os.path.join(RAVDESS_PATH, actor)

        for file in os.listdir(actor_path):

            if file.endswith(".wav"):

                parts = file.split("-")

                emotion_code = parts[2]

                emotion = emotion_map.get(emotion_code)

                file_path = os.path.join(actor_path, file)

                data.append({
                    "path": file_path,
                    "emotion": emotion
                })

    return pd.DataFrame(data)
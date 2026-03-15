import os
import pandas as pd

RAVDESS_PATH = "datasets/speech_emotion/RAVDESS"

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

label_map = {
    "Neutral": 0,
    "Calm": 1,
    "Happy": 2,
    "Sad": 3,
    "Angry": 4,
    "Anxious": 5,
    "Frustrated": 6,
    "Surprised": 7
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

                label = label_map[emotion]

                file_path = os.path.join(actor_path, file)

                data.append({
                    "path": file_path,
                    "emotion": emotion,
                    "label": label
                })

    return pd.DataFrame(data)
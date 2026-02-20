import os
import numpy as np
import librosa
from tqdm import tqdm
from sklearn.preprocessing import LabelEncoder
from tensorflow.keras.utils import to_categorical

DATA_PATH = "datasets/ravdess/audio_speech_actors_01-24"

sr = 22050
n_mels = 128
duration = 3
max_len = sr * duration

emotion_map = {
    "01": "neutral",
    "02": "calm",
    "03": "happy",
    "04": "sad",
    "05": "angry",
    "06": "anxious",
    "07": "frustrated",
    "08": "surprised"
}

X = []
y = []

print("Processing audio files...")

for root, dirs, files in os.walk(DATA_PATH):
    for file in tqdm(files):
        if file.endswith(".wav"):
            file_path = os.path.join(root, file)

            emotion_code = file.split("-")[2]
            emotion = emotion_map[emotion_code]

            signal, _ = librosa.load(file_path, sr=sr)

            # Fix duration
            if len(signal) < max_len:
                signal = np.pad(signal, (0, max_len - len(signal)))
            else:
                signal = signal[:max_len]

            # Generate Mel Spectrogram
            mel_spec = librosa.feature.melspectrogram(
                y=signal,
                sr=sr,
                n_mels=n_mels
            )

            mel_spec = librosa.power_to_db(mel_spec, ref=np.max)

            # Fix time dimension to 128
            if mel_spec.shape[1] < 128:
                pad_width = 128 - mel_spec.shape[1]
                mel_spec = np.pad(mel_spec, ((0,0),(0,pad_width)))
            else:
                mel_spec = mel_spec[:, :128]

            X.append(mel_spec)
            y.append(emotion)

X = np.array(X)
X = X[..., np.newaxis]

# Normalize
X = (X - X.min()) / (X.max() - X.min())

# Encode labels
le = LabelEncoder()
y_encoded = le.fit_transform(y)
y_categorical = to_categorical(y_encoded)

os.makedirs("preprocessed_audio_data", exist_ok=True)

np.save("preprocessed_audio_data/X.npy", X)
np.save("preprocessed_audio_data/y.npy", y_categorical)
np.save("preprocessed_audio_data/label_classes.npy", le.classes_)

print("Preprocessing complete!")
print("Shape:", X.shape)
print("Classes:", le.classes_)

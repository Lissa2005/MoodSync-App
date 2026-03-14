import os
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import (
    Input,
    Conv2D,
    MaxPooling2D,
    BatchNormalization,
    Dropout,
    Flatten,
    Dense
)
from tensorflow.keras.callbacks import EarlyStopping, ReduceLROnPlateau
from tensorflow.keras.utils import to_categorical
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
import joblib

DATA_PATH = "./preprocessed_audio_data"
MODEL_PATH = "./models/speech_model_trained.keras"

print("Loading data...")

X = np.load(os.path.join(DATA_PATH, "X.npy"))
y = np.load(os.path.join(DATA_PATH, "y.npy"))

print("X shape:", X.shape)
print("y shape:", y.shape)

print("Original y shape:", y.shape)

# If y is already one-hot encoded
if len(y.shape) == 2:
    y_labels = np.argmax(y, axis=1)
else:
    y_labels = y

label_encoder = LabelEncoder()
y_labels = label_encoder.fit_transform(y_labels)

print("y_labels shape (after fix):", y_labels.shape)

# Split using 1D labels
X_train, X_val, y_train_labels, y_val_labels = train_test_split(
    X,
    y_labels,
    test_size=0.2,
    random_state=42,
    stratify=y_labels
)

# Convert back to one-hot for training
NUM_CLASSES = len(np.unique(y_labels))

y_train = to_categorical(y_train_labels, NUM_CLASSES)
y_val = to_categorical(y_val_labels, NUM_CLASSES)

print("Split successful.")
print("Train labels shape:", y_train.shape)
print("Val labels shape:", y_val.shape)

# Model
model = Sequential([
    Input(shape=(128, 128, 1)),

    tf.keras.layers.RandomTranslation(0.1, 0.1),
    tf.keras.layers.RandomZoom(0.1),

    Conv2D(32, (3,3), activation='relu'),
    BatchNormalization(),
    MaxPooling2D(2,2),
    Dropout(0.25),

    Conv2D(64, (3,3), activation='relu'),
    BatchNormalization(),
    MaxPooling2D(2,2),
    Dropout(0.3),

    Conv2D(128, (3,3), activation='relu'),
    BatchNormalization(),
    MaxPooling2D(2,2),
    Dropout(0.4),

    Flatten(),
    Dense(256, activation='relu'),
    Dropout(0.5),
    Dense(NUM_CLASSES, activation='softmax')
])

model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

model.summary()

callbacks = [
    EarlyStopping(patience=8, restore_best_weights=True),
    ReduceLROnPlateau(patience=4)
]

history = model.fit(
    X_train,
    y_train,
    validation_data=(X_val, y_val),
    epochs=50,
    batch_size=32,
    callbacks=callbacks
)

os.makedirs("./models", exist_ok=True)

model.save(MODEL_PATH)
joblib.dump(label_encoder, "./models/label_encoder.pkl")

print("Training complete.")
print("Model saved to:", MODEL_PATH)
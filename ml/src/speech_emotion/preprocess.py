import librosa
import numpy as np


def load_audio(path):

    speech, sr = librosa.load(path, sr=16000)

    return speech


def extract_features(path):

    audio = load_audio(path)

    return audio
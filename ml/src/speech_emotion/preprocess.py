import librosa


def load_audio(path):

    speech, sr = librosa.load(path, sr=16000)

    return speech
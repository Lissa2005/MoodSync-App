
# Emotion Mapper

# Converts dataset/model emotions to MoodSync emotions.
# This ensures consistency across text and speech models.


MOODSYNC_EMOTIONS = [
    "Happy",
    "Sad",
    "Angry",
    "Calm",
    "Anxious",
    "Frustrated",
    "Neutral",
    "Surprised"
]

EMOTION_MAPPING = {

    "joy": "Happy",
    "love": "Happy",

    "sadness": "Sad",

    "anger": "Angry",

    "fear": "Anxious",

    "disgust": "Frustrated",

    "surprise": "Surprised",

    "neutral": "Neutral"
}


def map_emotion(predicted_emotion):

    predicted_emotion = predicted_emotion.lower()

    if predicted_emotion in EMOTION_MAPPING:
        return EMOTION_MAPPING[predicted_emotion]

    return "Neutral"
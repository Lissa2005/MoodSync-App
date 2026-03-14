
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


# Mapping from model/dataset emotions to MoodSync emotions
EMOTION_MAPPING = {

    # positive emotions
    "joy": "Happy",
    "happiness": "Happy",
    "excited": "Happy",

    # sadness
    "sadness": "Sad",
    "sad": "Sad",

    # anger
    "anger": "Angry",
    "angry": "Angry",

    # calm
    "calm": "Calm",
    "relaxed": "Calm",
    "content": "Calm",

    # anxiety
    "fear": "Anxious",
    "anxiety": "Anxious",
    "nervous": "Anxious",

    # frustration
    "disgust": "Frustrated",
    "frustration": "Frustrated",

    # neutral
    "neutral": "Neutral",

    # surprise
    "surprise": "Surprised",
    "surprised": "Surprised"
}


def map_emotion(predicted_emotion: str) -> str:
    
    # Convert model predicted emotion to MoodSync emotion
    

    predicted_emotion = predicted_emotion.lower()

    if predicted_emotion in EMOTION_MAPPING:
        return EMOTION_MAPPING[predicted_emotion]

    # fallback
    return "Neutral"
import torch
from transformers import DistilBertTokenizer
from transformers import DistilBertForSequenceClassification

from src.common.emotion_mapper import map_emotion


model_path = "models/text_emotion_model"

tokenizer = DistilBertTokenizer.from_pretrained(model_path)

model = DistilBertForSequenceClassification.from_pretrained(model_path)

model.eval()


labels = [
    "sadness",
    "joy",
    "love",
    "anger",
    "fear",
    "surprise"
]


def predict_text_emotion(text):

    inputs = tokenizer(
        text,
        return_tensors="pt",
        truncation=True,
        padding=True
    )

    with torch.no_grad():

        outputs = model(**inputs)

    predicted_class = torch.argmax(outputs.logits).item()

    emotion = labels[predicted_class]

    mapped_emotion = map_emotion(emotion)

    return mapped_emotion
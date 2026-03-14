import torch
from transformers import TrainingArguments, Trainer
from datasets import Dataset

from src.speech_emotion.dataset import load_ravdess
from src.speech_emotion.preprocess import extract_features
from src.speech_emotion.model import model, processor


def preprocess(batch):

    audio = extract_features(batch["path"])

    inputs = processor(
        audio,
        sampling_rate=16000,
        return_tensors="pt",
        padding=True
    )

    batch["input_values"] = inputs.input_values[0]

    return batch


def train():

    df = load_ravdess()

    dataset = Dataset.from_pandas(df)

    dataset = dataset.map(preprocess)

    training_args = TrainingArguments(
        output_dir="models/speech_emotion_model",
        per_device_train_batch_size=2,
        gradient_accumulation_steps=4,
        num_train_epochs=10,
        logging_steps=10,
        save_steps=500,
        fp16=True
    )

    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=dataset
    )

    trainer.train()

    trainer.save_model("models/speech_emotion_model")
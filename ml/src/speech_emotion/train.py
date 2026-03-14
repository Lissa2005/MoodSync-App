import torch
from datasets import Dataset
from transformers import TrainingArguments, Trainer

from src.speech_emotion.dataset import load_ravdess
from src.speech_emotion.preprocess import load_audio
from src.speech_emotion.model import model, processor


def preprocess(batch):

    audio = load_audio(batch["path"])

    inputs = processor(
        audio,
        sampling_rate=16000,
        return_tensors="pt",
        padding=True
    )

    batch["input_values"] = inputs.input_values[0]
    batch["labels"] = batch["label"]

    return batch


def train():

    df = load_ravdess()

    dataset = Dataset.from_pandas(df)

    dataset = dataset.map(preprocess)

    dataset = dataset.remove_columns(["path", "emotion", "label"])

    training_args = TrainingArguments(

        output_dir="./models/speech_emotion_model",

        per_device_train_batch_size=1,

        gradient_accumulation_steps=8,

        num_train_epochs=10,

        logging_steps=10,

        save_steps=200,

        fp16=torch.cuda.is_available(),

    )

    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=dataset
    )

    trainer.train()

    trainer.save_model("./models/speech_emotion_model")

    processor.save_pretrained("./models/speech_emotion_model")
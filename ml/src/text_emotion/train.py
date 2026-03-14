import torch
from transformers import Trainer, TrainingArguments

from src.text_emotion.dataset import load_text_datasets
from src.text_emotion.model import load_text_model
from src.text_emotion.tokenizer import load_tokenizer


device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Using device:", device)


def tokenize_function(examples, tokenizer):

    return tokenizer(
        examples["text"],
        padding="max_length",
        truncation=True,
        max_length=256
    )


def train():

    dataset = load_text_datasets()

    tokenizer = load_tokenizer()

    tokenized_dataset = dataset.map(
        lambda x: tokenize_function(x, tokenizer),
        batched=True
    )

    model = load_text_model(num_labels=6)

    training_args = TrainingArguments(
        output_dir="./models/text_model",
        eval_strategy="epoch",
        learning_rate=2e-5,
        per_device_train_batch_size=16,
        per_device_eval_batch_size=16,
        num_train_epochs=5,
        weight_decay=0.01,
        logging_dir="./logs",
    )

    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=tokenized_dataset["train"],
        eval_dataset=tokenized_dataset["validation"],
    )

    trainer.train()

    trainer.save_model("./models/text_emotion_model")


if __name__ == "__main__":
    train()
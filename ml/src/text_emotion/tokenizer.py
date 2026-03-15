from transformers import DistilBertTokenizer


def load_tokenizer():

    tokenizer = DistilBertTokenizer.from_pretrained(
        "distilbert-base-uncased"
    )

    return tokenizer
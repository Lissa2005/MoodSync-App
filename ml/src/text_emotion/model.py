from transformers import DistilBertForSequenceClassification


def load_text_model(num_labels):
    """
    Load DistilBERT model for emotion classification
    """

    model = DistilBertForSequenceClassification.from_pretrained(
        "distilbert-base-uncased",
        num_labels=num_labels
    )

    return model
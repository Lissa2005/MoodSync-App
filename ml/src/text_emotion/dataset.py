from datasets import load_dataset


def load_text_datasets():
    """
    Load emotion datasets for training
    """

    # HuggingFace emotion dataset
    dataset = load_dataset("emotion")

    return dataset
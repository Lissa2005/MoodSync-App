from transformers import Wav2Vec2ForSequenceClassification
from transformers import Wav2Vec2Processor


MODEL_NAME = "facebook/wav2vec2-base"

processor = Wav2Vec2Processor.from_pretrained(MODEL_NAME)

model = Wav2Vec2ForSequenceClassification.from_pretrained(
    MODEL_NAME,
    num_labels=8,
    use_safetensors=True
)
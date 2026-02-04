import pandas as pd
import os

print("Current directory:", os.getcwd())

# Load GoEmotions dataset
df = pd.read_csv(
    "../datasets/goemotions/train.tsv",
    sep="\t",
    header=None
)

print(f"Loaded {len(df)} rows")

# Rename columns
df.columns = ["text", "labels", "id"]

# Remove empty rows
df = df.dropna(subset=["text"])

# Keep required columns
df = df[["text", "labels"]]

# Create outputs folder if it doesn't exist
os.makedirs("outputs", exist_ok=True)

# Save cleaned data
df.to_csv("outputs/cleaned_text.csv", index=False)

print("Text preprocessing done! File saved.")
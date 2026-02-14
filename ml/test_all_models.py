print("TESTING ALL MODELS")
print("=" * 40)

print("1. Testing text model...")
exec(open("text_model/scripts/text_emotion.py").read())

print("\n2. Testing speech model...")
exec(open("speech_model/scripts/speech_emotion.py").read())

print("\n" + "=" * 40)
print("COMPLETE!")
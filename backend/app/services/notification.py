from firebase_admin import messaging

def send_mood_alert(registration_token: str, title: str, body: str):
    """
    Sends a push notification to a specific device.
    registration_token: The unique ID from the Flutter app.
    """
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body,
        ),
        token=registration_token,
    )

    try:
        response = messaging.send(message)
        print('Successfully sent message:', response)
        return response
    except Exception as e:
        print('Error sending message:', e)
        return None

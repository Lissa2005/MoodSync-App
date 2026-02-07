import 'package:flutter/material.dart';

class MoodInputScreen extends StatefulWidget{
  const MoodInputScreen({super.key});

  @override
  State<MoodInputScreen> createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  double _moodLevel = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Mood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Mood slider
            Slider(
              value: _moodLevel,
              min: 1,
              max: 5,
              divisions: 4,
              label: _moodLevel.round().toString(),
              onChanged: (value) {
                setState(() {
                  _moodLevel = value;
                });
              },
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                _moodText(),
                style: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmation(context);
                },
                child: const Text('Save Mood'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _moodText() {
    switch (_moodLevel.round()) {
      case 1:
        return '😞 Very Sad';
      case 2:
        return '😐 Sad';
      case 3:
        return '🙂 Neutral';
      case 4:
        return '😊 Happy';
      case 5:
        return '😁 Very Happy';
      default:
        return '';
    }
  }

  void _showConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Mood Saved'),
        content: Text('Your mood today: ${_moodText()}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:moodsync/screens/recommendation_screen.dart';

class VoiceBasedPage extends StatefulWidget {
  const VoiceBasedPage({super.key});

  @override
  State<VoiceBasedPage> createState() => _VoiceBasedPageState();
}

class _VoiceBasedPageState extends State<VoiceBasedPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);

      _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  Future<void> _detectMood() async {
    if (_spokenText.isEmpty || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": _spokenText}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final detectedMood = data["emotion"];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecommendationScreen(mood: detectedMood),
          ),
        );
      } else {
        _showError();
      }
    } catch (e) {
      _showError();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Voice mood detection failed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Mood Detection")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Speak about how you feel",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _spokenText.isEmpty
                    ? "Your speech will appear here..."
                    : _spokenText,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            FloatingActionButton(
              onPressed: _isListening ? _stopListening : _startListening,
              backgroundColor:
              _isListening ? Colors.red : Colors.purple,
              child: Icon(
                _isListening ? Icons.mic_off : Icons.mic,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _detectMood,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Detect Mood"),
            ),
          ],
        ),
      ),
    );
  }
}

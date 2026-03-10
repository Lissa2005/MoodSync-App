import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moodsync/screens/recommendation_screen.dart';
import 'package:moodsync/provider/mood_provider.dart';
import 'package:provider/provider.dart';


class MoodManualInputPage extends StatefulWidget {
  const MoodManualInputPage({super.key});

  @override
  State<MoodManualInputPage> createState() => _MoodManualInputPageState();
}

class _MoodManualInputPageState extends State<MoodManualInputPage> {

  final TextEditingController _controller = TextEditingController();

  Future<void> _detectMood() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/predict"), // use "http://10.0.2.2:8000/predict" for emulator
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": text}),
      );

      if (!mounted) return;
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final detectedMood = data["emotion"];

        //store mood globally
        Provider.of<MoodProvider>(context, listen: false)
            .setMood(detectedMood);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RecommendationScreen(),
          ),
        );
      } else {
        _showError();
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      _showError();
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mood detection failed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Mood Detection"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Type how you are feeling...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _detectMood,
              child: const Text("Detect Mood"),
            ),
          ],
        ),
      ),
    );
  }
}
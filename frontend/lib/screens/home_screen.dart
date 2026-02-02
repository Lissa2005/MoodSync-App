import 'package:flutter/material.dart';
import './mood_input_Screen.dart';
import './Interactive_platform.dart';

class home_screen extends StatelessWidget{
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MoodSync')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _navButton(context, 'Enter Mood', const mood_input_Screen()),
          _navButton(context, 'Activities', const Interactive_platform()),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String text, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        child: Text(text),
      ),
    );
  }
}
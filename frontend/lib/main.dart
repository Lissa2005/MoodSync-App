import 'package:flutter/material.dart';
import 'screens/start_up_screens/welcome_screen.dart';

void main() {
  runApp(const MoodSyncApp());
}

class MoodSyncApp extends StatelessWidget {
  const MoodSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

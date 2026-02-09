import 'package:flutter/material.dart';
import 'screens/signin_screen.dart';
import 'package:moodsync/authenticator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodsync',
      home: const SigninScreen(),
    );
  }
}


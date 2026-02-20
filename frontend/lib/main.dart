import 'package:flutter/material.dart';
import 'package:moodsync/screens/side%20panel(home)/about_page.dart';
import 'package:moodsync/screens/side%20panel(home)/privacy.dart';
import 'screens/start_up_screens/welcome_screen.dart';
import 'screens/start_up_screens/signin_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MoodSyncApp());
}

class MoodSyncApp extends StatelessWidget {
  const MoodSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      //Default Theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),

        scaffoldBackgroundColor: const Color(0xE6E6FAFF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/welcome',
      //the path
      routes: {
        '/welcome': (_)=> const WelcomeScreen(),
        '/signin' : (_)=> const SigninScreen(),
        '/home' : (_)=> const HomeScreen(),//bottom navigation
        '/about': (_) => const AboutPage(),
        '/privacy': (_) => const PrivacyScreen(),
      },
    );
  }
}

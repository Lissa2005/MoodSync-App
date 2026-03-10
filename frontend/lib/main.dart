import 'package:flutter/material.dart';
import 'package:moodsync/screens/Profile%20Page/account_settings.dart';
import 'package:moodsync/screens/Profile%20Page/edit_profile.dart';
import 'package:moodsync/screens/Profile%20Page/notification.dart';
import 'package:moodsync/screens/recommendation_screen.dart';
import 'package:moodsync/screens/side%20panel(home)/about_page.dart';
import 'package:moodsync/screens/side%20panel(home)/feedback.dart';
import 'package:moodsync/screens/side%20panel(home)/help.dart';
import 'package:moodsync/screens/side%20panel(home)/privacy.dart';
import 'package:moodsync/screens/side%20panel(home)/profile.dart';
import 'package:moodsync/screens/start_up_screens/splash_screen.dart';
import 'screens/start_up_screens/welcome_screen.dart';
import 'screens/start_up_screens/signin_screen.dart';
import 'screens/home_screen.dart';
import 'package:moodsync/provider/mood_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => MoodProvider(),
          child: const MoodSyncApp(),
      ),
  );
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

        scaffoldBackgroundColor: const Color(0xE6D1BFF6),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/splash',
      //the path
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/welcome': (_) => const WelcomeScreen(),
        '/signin': (_) => const SigninScreen(),
        '/home': (_) => const HomeScreen(), //bottom navigation
        '/profile': (_) => const ProfileScreen(),
        '/editProfile':(_) => const EditProfileScreen(),
        '/about': (_) => const AboutPage(),
        '/privacy': (_) => const PrivacyScreen(),
        '/help': (_) => const HelpScreen(),
        '/account':(_) => const AccountSettingsScreen(),
        '/feedback':(_) => const FeedbackScreen(),
        '/notification': (_)=> const NotificationScreen(),

      }
    );
  }
}

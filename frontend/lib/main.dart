import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase Flutter package
import 'package:flutter/material.dart';
import 'package:moodsync/screens/Profile%20Page/account_settings.dart';
import 'package:moodsync/screens/Profile%20Page/edit_profile.dart';
import 'package:moodsync/screens/Profile%20Page/notification.dart';
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

Future<void> main() async {
  // ADDED: Supabase initialization (must be first)
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xarzyvoenynqdjmzjrru.supabase.co',
    anonKey: 'sb_publishable_Vx8vNUDuBEWiTz-e48tZyw_tpUPUNAO',
  );
  
  // Your existing code continues exactly as before
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
    return MaterialApp(
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
        '/editProfile': (_) => const EditProfileScreen(),
        '/about': (_) => const AboutPage(),
        '/privacy': (_) => const PrivacyScreen(),
        '/help': (_) => const HelpScreen(),
        '/account': (_) => const AccountSettingsScreen(),
        '/feedback': (_) => const FeedbackScreen(),
        '/notification': (_) => const NotificationScreen(),
      },
    );
  }
}

// REMOVED: This duplicate main() function was causing the error
// Future<void> main() async {
//   await Supabase.initialize(
//     url: 'https://nqvakdjobencwzmbogca.supabase.co',
//     anonKey: 'sb_publishable_zHTCpDWmgxJO2X2KaFXxvQ_3OLCvbv2',
//   );
//   runApp(MyApp());
// }
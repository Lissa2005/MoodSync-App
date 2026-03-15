import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:moodsync/provider/mood_provider.dart';
import 'package:moodsync/screens/start_up_screens/signin_screen.dart';
import 'package:moodsync/screens/home_screen.dart';
import 'package:moodsync/screens/side panel(home)/profile.dart';
import 'package:moodsync/screens/side panel(home)/about_page.dart';
import 'package:moodsync/screens/side panel(home)/privacy.dart';
import 'package:moodsync/screens/side panel(home)/help.dart';
import 'package:moodsync/screens/Profile Page/account_settings.dart';
import 'package:moodsync/screens/Profile Page/edit_profile.dart';
import 'package:moodsync/screens/side panel(home)/feedback.dart';
import 'package:moodsync/screens/Profile Page/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file before anything else
  await dotenv.load(fileName: 'assets/.env');

  // Connect Flutter to Supabase using keys from .env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
      routes: {
        '/signin':       (_) => const SigninScreen(),
        '/home':         (_) => const HomeScreen(),
        '/profile':      (_) => const ProfileScreen(),
        '/editProfile':  (_) => const EditProfileScreen(),
        '/about':        (_) => const AboutPage(),
        '/privacy':      (_) => const PrivacyScreen(),
        '/help':         (_) => const HelpScreen(),
        '/account':      (_) => const AccountSettingsScreen(),
        '/feedback':     (_) => const FeedbackScreen(),
        '/notification': (_) => const NotificationScreen(),
      },
    );
  }
}
```

---

Also make sure `assets/.env` exists in your frontend folder with at least placeholder values so Flutter analyze doesn't fail:
```
SUPABASE_URL=https://placeholder.supabase.co
SUPABASE_ANON_KEY=placeholder
API_URL=http://10.0.2.2:8000
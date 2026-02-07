import 'package:flutter/material.dart';
import 'package:moodsync/screens/activities_screen.dart';
import './about_page.dart';
import './mood_input_Screen.dart';
import './Interactive_platform.dart';
import './activities_screen.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MoodSync')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _homeCard(
              context,
              title: 'Enter Mood',
              subtitle: 'Log how you feel today',
              icon: Icons.mood,
              screen: MoodInputScreen(),
            ),
            _homeCard(
              context,
              title: 'Interactive Platform',
              subtitle: 'Improve your mood by sharing your story',
              icon: Icons.self_improvement,
              screen: InteractivePlatform (),
            ),
            _homeCard(
              context,
              title: 'About',
              subtitle: 'Learn more about MoodSync',
              icon: Icons.info_outline,
              screen: const AboutPage(),
            ),
            _homeCard(
              context,
              title: 'Activities',
              subtitle: 'Lets do some activities',
              icon: Icons.games,
              screen: const ActivitiesScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Widget screen,
      }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}
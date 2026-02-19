import 'package:flutter/material.dart';
import 'package:moodsync/screens/activities_screen.dart';
import 'Mood detection/mood_input_screen.dart';
import './interactive_platform.dart';
import 'package:moodsync/authenticator.dart';
import 'package:moodsync/screens/side panel(home)/feedback.dart';
import 'package:moodsync/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodSync'),
      ),
      // ✅ SIDE POPUP PANEL
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountName: Text(
                Authenticator.userName ?? 'MoodSync User',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              accountEmail: Text(
                Authenticator.email ?? 'user@moodsync.com',
              ),

              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: Authenticator.profileImageUrl != null
                    ? NetworkImage(Authenticator.profileImageUrl!)
                    : null,
                child: Authenticator.profileImageUrl == null
                    ? Text(
                  (Authenticator.userName ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                )
                    : null,
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // close drawer
              },
            ),

            ListTile(
              leading: const Icon(Icons.person_3_rounded),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),

            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/privacy');
              },
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/help');
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),

            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/feedback');
              },
            ),

            const Spacer(),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Authenticator.logout();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _homeCard(
              context,
              title: 'Enter Mood',
              subtitle: 'Log how you feel today',
              icon: Icons.mood,
              screen: const MoodInputScreen(),
            ),
            _homeCard(
              context,
              title: 'Interactive Platform',
              subtitle: 'Improve your mood by sharing your story',
              icon: Icons.self_improvement,
              screen: const InteractivePlatform (),
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        selectedColor: Colors.lightBlue,
        onTap: (int p1) {  },),
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
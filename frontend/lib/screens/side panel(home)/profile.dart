import 'package:flutter/material.dart';
import 'package:moodsync/authenticator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEB2F4),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔹 Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Authenticator.userName ?? "User Name",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Authenticator.email ?? "user@email.com",
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                '/editProfile',
                                arguments: {
                                  'mood':'Happy',
                                  'primaryColor': Colors.yellow,
                                  'secondaryColor': Colors.orange,
                                  'accentColor': Colors.blue,
                                },
                            );
                          },
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            //Settings Section
            _settingsTile(
              context,
              icon: Icons.person,
              title: "Account Settings",
              subtitle: "Manage your account",
              routeName: '/account',
            ),

            _settingsTile(
              context,
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "Manage notifications",
              routeName: '/notification',
            ),

            _settingsTile(
              context,
              icon: Icons.lock,
              title: "Privacy & Security",
              subtitle: "Control your privacy",
              routeName: '/privacy',
            ),

            _settingsTile(
              context,
              icon: Icons.help,
              title: "Help & Support",
              subtitle: "Get help & feedback",
              routeName: '/help',
            ),

            const SizedBox(height: 20),

            // 🔹 Logout Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Authenticator.logout();
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required String routeName,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}
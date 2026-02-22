import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _HelpSectionTitle('Getting Started'),
            _HelpSectionText(
              '• Create an account or sign in to begin.\n'
                  '• Log your mood daily to receive personalized suggestions.\n'
                  '• Explore music, activities, and stories based on your mood.',
            ),

            _HelpSectionTitle('Mood Detection'),
            _HelpSectionText(
              'You can enter your mood by typing or speaking. '
                  'MoodSync uses AI-powered analysis to understand your emotions.',
            ),

            _HelpSectionTitle('Community Stories'),
            _HelpSectionText(
              'Share your thoughts anonymously. '
                  'Be respectful and supportive when commenting on others’ posts.',
            ),

            _HelpSectionTitle('Account & Privacy'),
            _HelpSectionText(
              '• Your data is private and secure.\n'
                  '• You can log out anytime from the menu.\n'
                  '• Users under 12 are not eligible to sign up.',
            ),

            _HelpSectionTitle('Troubleshooting'),
            _HelpSectionText(
              '• App not responding? Restart the app.\n'
                  '• Features missing? Check your internet connection.\n'
                  '• Still having issues? Contact support.',
            ),

            _HelpSectionTitle('Contact Support'),
            _HelpSectionText(
              'If you need further assistance, email us at:\n'
                  'support@moodsync.app',
            ),

            SizedBox(height: 30),
            Center(
              child: Text(
                'We’re here to help 💜',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Reusable Widgets

class _HelpSectionTitle extends StatelessWidget {
  final String text;
  const _HelpSectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _HelpSectionText extends StatelessWidget {
  final String text;
  const _HelpSectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.5,
      ),
    );
  }
}
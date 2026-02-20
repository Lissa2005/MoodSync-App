import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _SectionTitle('Your Privacy Matters'),
            _SectionText(
              'MoodSync respects your privacy and is committed to protecting '
                  'your personal information. This Privacy Policy explains how '
                  'we collect, use, and safeguard your data.',
            ),

            _SectionTitle('Information We Collect'),
            _SectionText(
              '- Basic account information such as email and username\n'
                  '- Mood entries and activity preferences\n'
                  '- Anonymous stories shared in the community\n\n'
                  'We do NOT collect sensitive personal identifiers.',
            ),

            _SectionTitle('How We Use Your Information'),
            _SectionText(
              '- To personalize your mood-based experience\n'
                  '- To improve app features and usability\n'
                  '- To provide mental wellness insights\n\n'
                  'Your data is never sold to third parties.',
            ),

            _SectionTitle('Anonymous Content'),
            _SectionText(
              'Stories and comments posted in the community section '
                  'are completely anonymous. Other users cannot identify you.',
            ),

            _SectionTitle('Data Security'),
            _SectionText(
              'We use reasonable technical and organizational measures '
                  'to protect your data from unauthorized access.',
            ),

            _SectionTitle('Children’s Privacy'),
            _SectionText(
              'MoodSync does not allow users under the age of 12 to create '
                  'an account. If you believe a child has provided data, '
                  'please contact us.',
            ),

            _SectionTitle('Your Rights'),
            _SectionText(
              'You may request access, correction, or deletion of your data '
                  'at any time through the app settings.',
            ),

            _SectionTitle('Updates to This Policy'),
            _SectionText(
              'We may update this Privacy Policy from time to time. '
                  'Any changes will be reflected within the app.',
            ),

            SizedBox(height: 30),
            Center(
              child: Text(
                'Last updated: 2026',
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

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

class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.5),
    );
  }
}
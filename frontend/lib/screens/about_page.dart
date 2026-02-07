import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About MoodSync'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'MoodSync',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'MoodSync is a mental wellness application designed to help users '
                  'track their moods, engage in positive activities, and receive '
                  'personalized recommendations to improve emotional well-being.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('• Daily mood tracking'),
            Text('• Activity suggestions'),
            Text('• Personalized recommendations'),
            Text('• Simple and user-friendly interface'),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Version',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text('1.0.0'),
          ],
        ),
      ),
    );
  }
}

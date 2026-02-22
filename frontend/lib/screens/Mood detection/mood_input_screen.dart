import 'package:flutter/material.dart';
import 'package:moodsync/screens/Mood detection/voice_based.dart';
import 'package:moodsync/screens/Mood detection/text_based.dart';
import 'package:moodsync/screens/Mood detection/quiz_page.dart';

class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({super.key});

  @override
  State<MoodInputScreen> createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Big welcome text
              const SizedBox(height: 30),
              const Text(
                'So Let Us Know',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.deepPurple,
                ),
              ),
              const Text(
                'How You Feel Today',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose how you\'d like to share your mood:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              // Three cards
              Expanded(
                child: ListView(
                  children: [
                    // Voice Card
                    _buildMoodCard(
                      title: 'Voice Input',
                      description: 'Tell us how you feel',
                      icon: Icons.mic,
                      gradientColors: [Colors.blue.shade200, Colors.purple.shade400],
                      screen: const VoiceBasedPage(),
                    ),

                    const SizedBox(height: 20),

                    // Manual Card
                    _buildMoodCard(
                      title: 'Manual Input',
                      description: 'Slide to select your mood',
                      icon: Icons.mood,
                      gradientColors: [Colors.blue.shade300, Colors.purple.shade500],
                      screen: const MoodManualInputPage(),
                    ),

                    const SizedBox(height: 20),

                    // Quiz Card
                    _buildMoodCard(
                      title: 'Take a Quiz',
                      description: 'Answer questions to find your mood',
                      icon: Icons.quiz,
                      gradientColors: [Colors.blue.shade400, Colors.purple.shade600],
                      screen: const MoodQuizPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodCard({
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradientColors,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                icon,
                size: 120,
                color: Colors.white.withOpacity(0.2),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon and title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Description and arrow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
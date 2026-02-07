import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget{
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities & Games'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _gameCard(
              context,
              title: 'Memory Game',
              icon: Icons.psychology,
              description: 'Improve focus and memory',
              onTap: () {
                _showComingSoon(context);
              },
            ),
            _gameCard(
              context,
              title: 'Breathing Game',
              icon: Icons.air,
              description: 'Relax with guided breathing',
              onTap: () {
                _showComingSoon(context);
              },
            ),
            _gameCard(
              context,
              title: 'Mood Quiz',
              icon: Icons.quiz,
              description: 'Understand your emotions',
              onTap: () {
                _showComingSoon(context);
              },
            ),
            _gameCard(
              context,
              title: 'Puzzle',
              icon: Icons.extension,
              description: 'Reduce stress with puzzles',
              onTap: () {
                _showComingSoon(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameCard(
      BuildContext context, {
        required String title,
        required String description,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text(
          'This game will be available in the next update.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
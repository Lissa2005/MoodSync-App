import 'package:flutter/material.dart';
import 'package:moodsync/screens/Music/music_screen.dart';
import 'package:moodsync/screens/food/food_screen.dart';
import 'package:moodsync/screens/interactive_platform.dart';
import 'package:moodsync/screens/activities_screen.dart';
import 'package:moodsync/widgets/mood_theme.dart';

class RecommendationScreen extends StatelessWidget {
  final String mood;

  const RecommendationScreen({
    super.key,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    final moodColor = MoodTheme.getMoodColors(mood);
    return Scaffold(
      backgroundColor: moodColor.secondary,
      appBar: AppBar(
        backgroundColor: moodColor.primary,
        elevation: 0,
        title: Text(
          "Your mood! - $mood ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _moodCard(moodColor),
            const SizedBox(height: 16),

            _sectionTitle('Choose Your Color Palette'),
            _paletteRow(),

            const SizedBox(height: 16),
            _customizeButton(),

            const SizedBox(height: 24),
            
            // Music Section
            _linkedSection(
              moodColor,
              context,
              title: 'Music',
              subtitle: 'Sunshine Vibes\n24 songs • 1h 45m',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MusicScreen(
                    mood: mood,
                    primaryColor: moodColor.primary,
                    secondaryColor: moodColor.secondary,
                    accentColor: moodColor.accent,
                  ),
                ),
              ),
            ),

            // Food Section
            _linkedSection(
              moodColor,
              context,
              title: 'Food',
              subtitle: 'Grilled Salmon\n★★★★★\nVegan Cake',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FoodScreen(
                    mood: mood,
                    primaryColor: moodColor.primary,
                    secondaryColor: moodColor.secondary,
                    accentColor: moodColor.accent,
                  ),
                ),
              ),
            ),

            // Stories Section
            _linkedSection(
              moodColor,
              context,
              title: 'Stories',
              subtitle: '"Whispers of the Heart"\nUplifting reads',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InteractivePlatform(),
                ),
              ),
            ),

            // Activities Section
            _linkedSection(
              moodColor,
              context,
              title: 'Activities',
              subtitle: 'Chess • Positivity Quiz\n15 min',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ActivitiesScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- UI COMPONENTS ----------------

  Widget _moodCard(moodColors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: moodColors.accent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.sentiment_satisfied, size: 40, color: Colors.green),
          const SizedBox(width: 12),
          Text(
            'You are feeling : $mood',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _paletteRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _paletteCard('Sunshine'),
        _paletteCard('Bright Day'),
        _paletteCard('Joyful'),
      ],
    );
  }

  Widget _paletteCard(String title) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Select', style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _customizeButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Customize your own'),
    );
  }

  Widget _linkedSection(
    MoodColors moodColors,
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        tileColor: moodColors.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

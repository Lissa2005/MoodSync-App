import 'package:flutter/material.dart';

class MoodManualInputPage extends StatefulWidget {
  const MoodManualInputPage({super.key});

  @override
  State<MoodManualInputPage> createState() => _MoodManualInputPageState();
}

class _MoodManualInputPageState extends State<MoodManualInputPage> {
  int _selectedMoodIndex = 3; // Default to Calm (index 3)

  // Custom color constants
  static const Color sunshineYellow = Color(0xFFFFD93D);
  static const Color warmOrange = Color(0xFFFF8A5C);
  static const Color softGold = Color(0xFFF9E076);

  static const Color softBlue = Color(0xFF6C9EBF);
  static const Color dustyLavender = Color(0xFF9B9FB5);
  static const Color mistyGray = Color(0xFFC7D3DD);

  static const Color deepRed = Color(0xFFD14D4D);
  static const Color burntOrange = Color(0xFFC45D42);
  static const Color darkBurgundy = Color(0xFF8B3A3A);

  static const Color sageGreen = Color(0xFF8FBC94);
  static const Color softTeal = Color(0xFFA5D6D9);
  static const Color mistyMint = Color(0xFFC5E0D4);

  static const Color softLavender = Color(0xFFB8A9C9);
  static const Color mutedPurple = Color(0xFF9B8BB0);
  static const Color lightGray = Color(0xFFD9D0DE);

  static const Color terracotta = Color(0xFFC96E6E);
  static const Color dustyRose = Color(0xFFB85C5C);
  static const Color warmBeige = Color(0xFFE8C7B5);

  static const Color electricPurple = Color(0xFF9B5DE5);
  static const Color brightFuchsia = Color(0xFFF15BB5);
  static const Color vibrantBlue = Color(0xFF00BBF9);

  static const Color warmGray = Color(0xFFBEBEBE);
  static const Color softBeige = Color(0xFFF5F0E1);
  static const Color mutedTaupe = Color(0xFFC7B8A5);

  // List of moods with their properties and custom colors
  final List<Map<String, dynamic>> _moods = [
    {
      'name': 'Happy',
      'emoji': '😊',
      'primaryColor': sunshineYellow,
      'secondaryColor': warmOrange,
      'accentColor': softGold,
      'description': 'Feeling joyful and positive'
    },
    {
      'name': 'Sad',
      'emoji': '😢',
      'primaryColor': softBlue,
      'secondaryColor': dustyLavender,
      'accentColor': mistyGray,
      'description': 'Feeling down or sorrowful'
    },
    {
      'name': 'Angry',
      'emoji': '😠',
      'primaryColor': deepRed,
      'secondaryColor': burntOrange,
      'accentColor': darkBurgundy,
      'description': 'Feeling frustrated or annoyed'
    },
    {
      'name': 'Calm',
      'emoji': '😌',
      'primaryColor': sageGreen,
      'secondaryColor': softTeal,
      'accentColor': mistyMint,
      'description': 'Feeling peaceful and relaxed'
    },
    {
      'name': 'Anxious',
      'emoji': '😰',
      'primaryColor': softLavender,
      'secondaryColor': mutedPurple,
      'accentColor': lightGray,
      'description': 'Feeling worried or nervous'
    },
    {
      'name': 'Frustrated',
      'emoji': '😤',
      'primaryColor': terracotta,
      'secondaryColor': dustyRose,
      'accentColor': warmBeige,
      'description': 'Feeling irritated or stuck'
    },
    {
      'name': 'Surprised',
      'emoji': '😲',
      'primaryColor': electricPurple,
      'secondaryColor': brightFuchsia,
      'accentColor': vibrantBlue,
      'description': 'Feeling shocked or amazed'
    },
    {
      'name': 'Neutral',
      'emoji': '😐',
      'primaryColor': warmGray,
      'secondaryColor': softBeige,
      'accentColor': mutedTaupe,
      'description': 'Feeling neither good nor bad'
    },
  ];

  // Helper getter for current mood's primary color
  Color get _currentPrimaryColor => _moods[_selectedMoodIndex]['primaryColor'];

  // Helper getter for current mood's secondary color
  Color get _currentSecondaryColor => _moods[_selectedMoodIndex]['secondaryColor'];

  // Helper getter for current mood's accent color
  Color get _currentAccentColor => _moods[_selectedMoodIndex]['accentColor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'How are you feeling?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _currentPrimaryColor,
        foregroundColor: _getContrastTextColor(_currentPrimaryColor),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _currentPrimaryColor.withOpacity(0.15),
              _currentSecondaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Selected mood visualization (large display)
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _currentPrimaryColor.withOpacity(0.8),
                      _currentSecondaryColor.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: _currentPrimaryColor.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _moods[_selectedMoodIndex]['emoji'],
                      style: const TextStyle(fontSize: 100),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _moods[_selectedMoodIndex]['name'],
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: _getContrastTextColor(_currentPrimaryColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _moods[_selectedMoodIndex]['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: _getContrastTextColor(_currentPrimaryColor).withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Mood selection text
              const Text(
                'Select your mood:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Mood grid (2 rows of 4 columns)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _moods.length,
                  itemBuilder: (context, index) {
                    return _buildMoodItem(index);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Save button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      _currentPrimaryColor,
                      _currentSecondaryColor,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _currentPrimaryColor.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _showConfirmation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: _getContrastTextColor(_currentPrimaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Save Mood',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodItem(int index) {
    bool isSelected = _selectedMoodIndex == index;
    Color moodPrimaryColor = _moods[index]['primaryColor'];
    Color moodSecondaryColor = _moods[index]['secondaryColor'];
    Color moodAccentColor = _moods[index]['accentColor'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMoodIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              moodPrimaryColor,
              moodSecondaryColor,
            ],
          )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: moodPrimaryColor,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: moodPrimaryColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ] : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _moods[index]['emoji'],
              style: TextStyle(
                fontSize: 30,
                color: isSelected ? Colors.white : moodPrimaryColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _moods[index]['name'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : moodPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Mood Saved',
          style: TextStyle(
            color: _currentPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    _currentPrimaryColor.withOpacity(0.2),
                    _currentSecondaryColor.withOpacity(0.1),
                  ],
                ),
              ),
              child: Text(
                _moods[_selectedMoodIndex]['emoji'],
                style: const TextStyle(fontSize: 60),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Your mood today:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              _moods[_selectedMoodIndex]['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _currentPrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _currentPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _moods[_selectedMoodIndex]['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to main mood screen
            },
            style: TextButton.styleFrom(
              foregroundColor: _currentPrimaryColor,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Helper method to determine text color (white or black) based on background color brightness
  Color _getContrastTextColor(Color backgroundColor) {
    // Calculate luminance to determine if background is light or dark
    double luminance = (0.299 * backgroundColor.red +
        0.587 * backgroundColor.green +
        0.114 * backgroundColor.blue) / 255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
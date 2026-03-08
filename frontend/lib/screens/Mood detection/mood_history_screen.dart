import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class SimpleMoodHistoryScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const SimpleMoodHistoryScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<SimpleMoodHistoryScreen> createState() =>
      _SimpleMoodHistoryScreenState();
}

class _SimpleMoodHistoryScreenState extends State<SimpleMoodHistoryScreen> {
  // selected time filter
  String selectedFilter = 'Week';
  final List<String> weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  int currentMonth = 3;
  int currentYear = 2025;

  // sample mood history data
  final List<Map<String, dynamic>> allmoodHistory = [
    {
      'date': 'Feb 25',
      'day': 'Monday',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D)
    },
    {
      'date': 'Feb 24',
      'day': 'Sunday',
      'mood': 'Calm',
      'emoji': '😌',
      'color': const Color(0xFF8FBC94)
    },
    {
      'date': 'Feb 23',
      'day': 'Saturday',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D)
    },
    {
      'date': 'Feb 22',
      'day': 'Friday',
      'mood': 'Neutral',
      'emoji': '😐',
      'color': const Color(0xFFBEBEBE)
    },
    {
      'date': 'Feb 21',
      'day': 'Thursday',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D)
    },
    {
      'date': 'Feb 20',
      'day': 'Wednesday',
      'mood': 'Sad',
      'emoji': '😔',
      'color': const Color(0xFF6C9EBF)
    },
    {
      'date': 'Feb 19',
      'day': 'Tuesday',
      'mood': 'Calm',
      'emoji': '😌',
      'color': const Color(0xFF8FBC94)
    },
    {
      'date': 'Feb 18',
      'day': 'Monday',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D)
    },
    {
      'date': 'Feb 17',
      'day': 'Sunday',
      'mood': 'Anxious',
      'emoji': '😰',
      'color': const Color(0xFFB8A9C9)
    },
  ];

  // mood count
  Map<String, int> get moodStats {
    Map<String, int> stats = {};
    for (var entry in allmoodHistory) {
      String mood = entry['mood'];
      stats[mood] = (stats[mood] ?? 0) + 1;
    }
    return stats;
  }

  // get filtered data based on selected time
  List<Map<String, dynamic>> get filteredHistory {
    if (selectedFilter == 'Week') {
      return allmoodHistory.take(7).toList();
    } else if (selectedFilter == 'Month') {
      return allmoodHistory.take(9).toList();
    } else {
      return allmoodHistory;
    }
  }

  // mini calender
  List<Map<String, dynamic>> get calendarDays {
    // 28 days for calendar 
    List<Map<String, dynamic>> days = [];
    List<String> moods = ['Happy', 'Calm', 'Neutral', 'Sad', 'Anxious'];
    List<Color> moodColors = [
      const Color(0xFFFFD93D),
      const Color(0xFF8FBC94),
      const Color(0xFFBEBEBE),
      const Color(0xFF6C9EBF),
      const Color(0xFFB8A9C9),
    ];

    for (int i = 1; i <= 28; i++) {
      // sample pattern
      int moodIndex = (i + 2) % moods.length;
      days.add({
        'day': i,
        'mood': moods[moodIndex],
        'color': moodColors[moodIndex],
        'hasData': true,
      });
    }
    return days;
  }

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF8F0FF),
              const Color(0xFFF0E6FF),
              const Color(0xFFE8D9FF),
              widget.primaryColor.withOpacity(0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // back button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: widget.secondaryColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mood History',
                        style: TextStyle(
                          color: widget.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // state history
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: moodStats.entries.map((entry) {
                            Color moodColor = _getMoodColor(entry.key);
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: moodColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: moodColor.withOpacity(0.3)),
                              ),
                              child: Text(
                                '${entry.key}: ${entry.value}',
                                style: TextStyle(
                                  color: moodColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // time filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildFilterButton('Week'),
                      const SizedBox(width: 10),
                      _buildFilterButton('Month'),
                      const SizedBox(width: 10),
                      _buildFilterButton('All'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // mini calendar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: widget.primaryColor.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // month and year
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'March 2025',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.secondaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    // previous month
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Previous month')),
                                    );
                                  },
                                  child: Icon(Icons.chevron_left,
                                      size: 20, color: widget.primaryColor),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {

                                    // next month
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Next month')),
                                    );
                                  },
                                  child: Icon(Icons.chevron_right,
                                      size: 20, color: widget.primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // weekday
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: weekdays.map((day) {
                            return Text(
                              day,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: widget.secondaryColor.withOpacity(0.7),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),

                        // calender grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: 28,
                          itemBuilder: (context, index) {
                            final dayData = calendarDays[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: dayData['color'].withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${dayData['day']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: dayData['color'],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLegendItem('Happy', const Color(0xFFFFD93D)),
                            const SizedBox(width: 12),
                            _buildLegendItem('Calm', const Color(0xFF8FBC94)),
                            const SizedBox(width: 12),
                            _buildLegendItem('Sad', const Color(0xFF6C9EBF)),
                            const SizedBox(width: 12),
                            _buildLegendItem(
                                'Anxious', const Color(0xFFB8A9C9)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // mood history list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredHistory.length,
                  itemBuilder: (context, index) {
                    final entry = filteredHistory[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: entry['color'].withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                entry['emoji'],
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry['date'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  entry['day'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: entry['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              entry['mood'],
                              style: TextStyle(
                                color: entry['color'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        selectedColor: widget.primaryColor,
        onTap: _onNavBarTap,
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return const Color(0xFFFFD93D);
      case 'Calm':
        return const Color(0xFF8FBC94);
      case 'Neutral':
        return const Color(0xFFBEBEBE);
      case 'Sad':
        return const Color(0xFF6C9EBF);
      case 'Anxious':
        return const Color(0xFFB8A9C9);
      default:
        return widget.primaryColor;
    }
  }

  // filter button widget
  Widget _buildFilterButton(String filterName) {
    bool isSelected = selectedFilter == filterName;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = filterName;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? widget.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? widget.primaryColor
                  : widget.primaryColor.withOpacity(0.3),
            ),
          ),
          child: Center(
            child: Text(
              filterName,
              style: TextStyle(
                color: isSelected ? Colors.white : widget.primaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // calendar legend item widget
  Widget _buildLegendItem(String mood, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          mood,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
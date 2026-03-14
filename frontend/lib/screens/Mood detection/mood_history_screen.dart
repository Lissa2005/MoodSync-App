import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:moodsync/provider/mood_provider.dart';
import 'package:moodsync/widgets/mood_theme.dart';

class SimpleMoodHistoryScreen extends StatefulWidget {
  final String? mood;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;

  const SimpleMoodHistoryScreen({
    super.key,
    this.mood,
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
  });

  @override
  State<SimpleMoodHistoryScreen> createState() =>
      _SimpleMoodHistoryScreenState();
}

class _SimpleMoodHistoryScreenState extends State<SimpleMoodHistoryScreen> {
  // selected time filter
  String selectedFilter = 'Week';
  final List<String> weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  //current date
  DateTime currentDate = DateTime.now();
  late int currentMonth;
  late int currentYear;

  //track selected date for details
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    currentMonth = currentDate.month;
    currentYear = currentDate.year;
  }

  // mood history data
  final List<Map<String, dynamic>> allmoodHistory = [
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'day': 'Yesterday',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D)
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'day': '2 days ago',
      'mood': 'Calm',
      'emoji': '😌',
      'color': const Color(0xFF8FBC94)
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'day': '3 days ago',
      'mood': 'Neutral',
      'emoji': '😐',
      'color': const Color(0xFFBEBEBE)
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'day': '4 days ago',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D)
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'day': '5 days ago',
      'mood': 'Sad',
      'emoji': '😔',
      'color': const Color(0xFF6C9EBF)
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 6)),
      'day': '6 days ago',
      'mood': 'Calm',
      'emoji': '😌',
      'color': const Color(0xFF8FBC94)
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'day': '1 week ago',
      'mood': 'Anxious',
      'emoji': '😰',
      'color': const Color(0xFFB8A9C9)
    },
  ];

  //detailed data for each date
  final Map<String, Map<String, dynamic>> dayDetails = {
    // yesterday
    DateTime.now()
        .subtract(const Duration(days: 1))
        .toIso8601String()
        .split('T')[0]: {
      'date': 'Yesterday',
      'day': 'Monday',
      'mood': 'Happy',
      'emoji': '😊',
      'color': const Color(0xFFFFD93D),
      'music': {
        'playlist': 'Happy Vibes Playlist',
        'songCount': 5,
        'duration': '20 min',
        'songs': ['Happy', 'Good Life', 'Walking On Sunshine']
      },
      'food': ['Sunshine Smoothie', 'Happy Tacos'],
      'activities': ['Meditation (10 min)', 'Played Crossword'],
    },

    // 2 days ago
    DateTime.now()
        .subtract(const Duration(days: 2))
        .toIso8601String()
        .split('T')[0]: {
      'date': '2 days ago',
      'day': 'Sunday',
      'mood': 'Calm',
      'emoji': '😌',
      'color': const Color(0xFF8FBC94),
      'music': {
        'playlist': 'Zen Garden',
        'songCount': 8,
        'duration': '32 min',
        'songs': ['Ocean Waves', 'Forest Rain', 'Peaceful Piano']
      },
      'food': ['Green Tea', 'Vegetable Soup'],
      'activities': ['Yoga (20 min)', 'Reading'],
    },

    // 3 days ago
    DateTime.now()
        .subtract(const Duration(days: 3))
        .toIso8601String()
        .split('T')[0]: {
      'date': '3 days ago',
      'day': 'Saturday',
      'mood': 'Neutral',
      'emoji': '😐',
      'color': const Color(0xFFBEBEBE),
      'music': {
        'playlist': 'Background Beats',
        'songCount': 10,
        'duration': '38 min',
        'songs': ['Lo-fi Beats', 'Jazz', 'Ambient']
      },
      'food': ['Sandwich', 'Coffee'],
      'activities': ['Work', 'Grocery Shopping'],
    },
  };

  // mood count
  Map<String, int> get moodStats {
    Map<String, int> stats = {};
    for (var entry in allmoodHistory) {
      String mood = entry['mood'];
      stats[mood] = (stats[mood] ?? 0) + 1;
    }
    return stats;
  }

  // get filtered data based on selected time - SHOW ONLY 3 DAYS
  List<Map<String, dynamic>> get filteredHistory {
    return allmoodHistory.take(3).toList(); // Only show last 3 days
  }

  // calender for current month
  List<Map<String, dynamic>> get calendarDays {
    List<Map<String, dynamic>> days = [];

    //first day of month and total days
    DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    int daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;
    int firstWeekday = firstDayOfMonth.weekday;

    //add empty cells for days before month starts
    for (int i = 1; i < firstWeekday; i++) {
      days.add({
        'day': null,
        'mood': null,
        'color': Colors.grey,
        'hasData': false,
      });
    }

    // add actual days
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime currentDay = DateTime(currentYear, currentMonth, i);

      //check if theis day has mood data
      var moodEntry = allmoodHistory.firstWhere(
        (entry) {
          DateTime entryDate = entry['date'] as DateTime;
          return entryDate.year == currentDay.year &&
              entryDate.month == currentDay.month &&
              entryDate.day == currentDay.day;
        },
        orElse: () => {},
      );

      Color dayColor;
      String? moodName;

      if (moodEntry.isNotEmpty) {
        dayColor = moodEntry['color'] ?? Colors.grey;
        moodName = moodEntry['mood'];
      } else {
        dayColor = Colors.grey.shade300;
        moodName = null;
      }

      days.add({
        'day': i,
        'mood': moodName,
        'color': dayColor,
        'hasData': moodEntry.isNotEmpty,
        'fullDate': currentDay,
      });
    }

    return days;
  }

  // show day details
  void showDayDetails(Map<String, dynamic> dayData) {
    // find the mood entry for this date
    DateTime? selectedFullDate = dayData['fullDate'];

    if (selectedFullDate == null) return;

    // create date key in same format as dayDetails
    String dateKey = selectedFullDate.toIso8601String().split('T')[0];

    var moodEntry = allmoodHistory.firstWhere(
      (entry) {
        DateTime entryDate = entry['date'] as DateTime;
        return entryDate.year == selectedFullDate.year &&
            entryDate.month == selectedFullDate.month &&
            entryDate.day == selectedFullDate.day;
      },
      orElse: () => {},
    );

    if (moodEntry.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No mood data for this day'),
          backgroundColor: moodColor.primary,
        ),
      );
      return;
    }

     // get detailed data from dayDetails map
     var detailedData = dayDetails[dateKey] ?? moodEntry;

    // navigate to detail page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayDetailScreen(
          moodData: detailedData,
          primaryColor: moodColor.primary,
          secondaryColor: moodColor.secondary,
          accentColor: moodColor.accent,
        ),
      ),
    );
  }

  // get mood colour from provider
  late MoodColors moodColor;

  @override
  Widget build(BuildContext context) {
    // get mood from provider
    final moodProvider = Provider.of<MoodProvider>(context);
    final currentMood = moodProvider.mood;
    moodColor = MoodTheme.getMoodColors(currentMood);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              moodColor.primary.withOpacity(0.1),
              moodColor.secondary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // back button with mood-based color
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        icon:
                            Icon(Icons.arrow_back, color: moodColor.secondary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mood History',
                        style: TextStyle(
                          color: moodColor.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 20),

                // time filter with mood colours
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

                // mini calendar with mood colors
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: moodColor.primary.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // month and year with navigation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_getMonthName(currentMonth)} $currentYear',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: moodColor.secondary,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (currentMonth == 1) {
                                        currentMonth = 12;
                                        currentYear--;
                                      } else {
                                        currentMonth--;
                                      }
                                    });
                                  },
                                  child: Icon(Icons.chevron_left,
                                      size: 20, color: moodColor.primary),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (currentMonth == 12) {
                                        currentMonth = 1;
                                        currentYear++;
                                      } else {
                                        currentMonth++;
                                      }
                                    });
                                  },
                                  child: Icon(Icons.chevron_right,
                                      size: 20, color: moodColor.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // weekday headers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: weekdays.map((day) {
                            return Text(
                              day,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: moodColor.secondary.withOpacity(0.7),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),

                        // calendar grid with proper tap functionality
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
                          itemCount: calendarDays.length,
                          itemBuilder: (context, index) {
                            final dayData = calendarDays[index];

                            if (dayData['day'] == null) {
                              return Container();
                            }

                            return GestureDetector(
                              onTap: () {
                                if (dayData['hasData'] == true) {
                                  showDayDetails(dayData);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: dayData['hasData'] == true
                                      ? (dayData['color'] as Color)
                                          .withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${dayData['day']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: dayData['hasData'] == true
                                          ? dayData['color']
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // legend with mood colors
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

                // mood history list only 3 days
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Moods',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: moodColor.secondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredHistory.length,
                        itemBuilder: (context, index) {
                          final entry = filteredHistory[index];
                          return GestureDetector(
                            onTap: () {
                              // create a dayData object for this entry
                              DateTime entryDate = entry['date'] as DateTime;
                              Map<String, dynamic> dayData = {
                                'day': entryDate.day,
                                'color': entry['color'],
                                'hasData': true,
                                'fullDate': entryDate,
                              };
                              showDayDetails(dayData);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: moodColor.primary.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (entry['color'] as Color)
                                          .withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        entry['emoji'] ?? '😊',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _formatDate(
                                              entry['date'] as DateTime),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          entry['day'] ?? '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: moodColor.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: (entry['color'] as Color)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      entry['mood'] ?? '',
                                      style: TextStyle(
                                        color: entry['color'],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        selectedColor: moodColor.primary,
        onTap: _onNavBarTap,
      ),
    );
  }

  // helper method to get month name
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'March';
    }
  }

  // helper method to format date
  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)}';
  }

  // filter button widget with mood colors
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
            color: isSelected ? moodColor.primary : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? moodColor.primary
                  : moodColor.primary.withOpacity(0.3),
            ),
          ),
          child: Center(
            child: Text(
              filterName,
              style: TextStyle(
                color: isSelected ? Colors.white : moodColor.primary,
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
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
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
}

// day detail screen
class DayDetailScreen extends StatelessWidget {
  final Map<String, dynamic> moodData;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const DayDetailScreen({
    super.key,
    required this.moodData,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mood Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // headrer with date and mood
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: (moodData['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        moodData['emoji'] ?? '😊',
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    moodData['day'] ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    moodData['date'].toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: (moodData['color'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      moodData['mood'] ?? '',
                      style: TextStyle(
                        color: moodData['color'],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // music section
            if (moodData['music'] != null)
              _buildDetailSection(
                icon: Icons.music_note,
                title: 'Music Recommended',
                color: moodData['color'],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moodData['music']['playlist'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${moodData['music']['songCount'] ?? 0} songs',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // food section
            if (moodData['food'] != null)
              _buildDetailSection(
                icon: Icons.restaurant,
                title: 'Food Recommended',
                color: moodData['color'],
                child: Wrap(
                  spacing: 8,
                  children: (moodData['food'] as List).map((item) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: (moodData['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: moodData['color'],
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 16),

            // activities section
            if (moodData['activities'] != null)
              _buildDetailSection(
                icon: Icons.self_improvement,
                title: 'Activities Done',
                color: moodData['color'],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (moodData['activities'] as List)
                      .map((activity) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: moodData['color'],
                                ),
                                const SizedBox(width: 8),
                                Text(activity),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailSection({
  required IconData icon,
  required String title,
  required Color color,
  required Widget child,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      child,
    ],
  );
}

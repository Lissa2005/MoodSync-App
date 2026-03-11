import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moodsync/provider/mood_provider.dart';
import 'package:moodsync/widgets/mood_theme.dart';
import 'music_player_screen.dart';

class SearchScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const SearchScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // sample song data
  final List<Map<String, dynamic>> _allSongs = [
    {
      'title': 'Happy',
      'artist': 'Pharrell Williams',
      'album': 'Happy',
      'duration': '3:53',
      'mood': 'happy',
      'popular': true,
    },
    {
      'title': 'Good Life',
      'artist': 'OneRepublic',
      'album': 'Good Life',
      'duration': '4:13',
      'mood': 'happy',
      'popular': true,
    },
    {
      'title': 'Walking On Sunshine',
      'artist': 'Katrina & The Waves',
      'album': 'Walking On Sunshine',
      'duration': '3:58',
      'mood': 'happy',
    },
    {
      'title': 'Someone Like You',
      'artist': 'Adele',
      'album': '21',
      'duration': '4:45',
      'mood': 'sad',
      'popular': true,
    },
    {
      'title': 'Fix You',
      'artist': 'Coldplay',
      'album': 'X&Y',
      'duration': '4:55',
      'mood': 'sad',
    },
    {
      'title': 'Ocean Waves',
      'artist': 'Nature Sounds',
      'album': 'Calm',
      'duration': '8:00',
      'mood': 'calm',
    },
    {
      'title': 'Weightless',
      'artist': 'Marconi Union',
      'album': 'Ambient',
      'duration': '8:00',
      'mood': 'calm',
      'popular': true,
    },
    {
      'title': 'Break Stuff',
      'artist': 'Limp Bizkit',
      'album': 'Significant Other',
      'duration': '2:46',
      'mood': 'angry',
    },
    {
      'title': 'Breathe Me',
      'artist': 'Sia',
      'album': 'Colour the Small One',
      'duration': '4:35',
      'mood': 'anxious',
    },
  ];

  List<Map<String, dynamic>> get _filteredSongs {
    if (_searchQuery.isEmpty) {
      // show popular songs when no search query
      return _allSongs.where((song) => song['popular'] == true).toList();
    }
    
    return _allSongs.where((song) {
      final titleLower = song['title'].toLowerCase();
      final artistLower = song['artist'].toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      return titleLower.contains(queryLower) || artistLower.contains(queryLower);
    }).toList();
  }

  List<Map<String, dynamic>> get _suggestedForMood {
    return _allSongs.where((song) => song['mood'] == widget.mood).take(3).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // get mood from provider
    final moodProvider = Provider.of<MoodProvider>(context);
    final currentMood = moodProvider.mood;
    final moodColor = MoodTheme.getMoodColors(currentMood);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              moodColor.primary.withOpacity(0.08),
              moodColor.secondary.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // back button and title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: moodColor.secondary),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: moodColor.primary.withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search songs, artists...',
                      prefixIcon: Icon(Icons.search, color: moodColor.primary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: moodColor.primary),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // searcg results
              Expanded(
                child: _searchQuery.isEmpty
                    ? _buildSuggestionsSection(moodColor)
                    : _buildSearchResults(moodColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsSection(MoodColors moodColor) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ssuggested for your mood
            if (_suggestedForMood.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Suggested for your mood',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: moodColor.secondary,
                ),
              ),
              const SizedBox(height: 12),
              ..._suggestedForMood.map((song) => _buildSongTile(song, moodColor)),
            ],

            const SizedBox(height: 24),

            // popular songs
            const Text(
              'Popular Songs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ..._allSongs
                .where((song) => song['popular'] == true)
                .map((song) => _buildSongTile(song, moodColor)),

            const SizedBox(height: 24),

            // browse by mood
            const Text(
              'Browse by Mood',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildMoodChips(moodColor),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(MoodColors moodColor) {
    final results = _filteredSongs;
    
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_off,
              size: 80,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            const Text(
              'No songs found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildSongTile(results[index], moodColor);
      },
    );
  }

  Widget _buildSongTile(Map<String, dynamic> song, MoodColors moodColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getMoodColor(song['mood']).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.music_note,
            color: _getMoodColor(song['mood']),
            size: 24,
          ),
        ),
        title: Text(
          song['title'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          song['artist'],
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              song['duration'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: moodColor.primary,
                shape: BoxShape.circle,
              ),
            ),
            IconButton(
              icon: Icon(Icons.play_arrow, color: moodColor.primary, size: 28),
              onPressed: () {
                _playSong(context, song, moodColor);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        onTap: () => _playSong(context, song, moodColor),
      ),
    );
  }

  Widget _buildMoodChips(MoodColors moodColor) {
    final moods = ['Happy', 'Sad', 'Calm', 'Angry', 'Anxious', 'Energetic', 'Sleepy'];
    final moodColors = {
      'Happy': const Color(0xFFFFD93D),
      'Sad': const Color(0xFF6C9EBF),
      'Calm': const Color(0xFF8FBC94),
      'Angry': const Color(0xFFD14D4D),
      'Anxious': const Color(0xFFB8A9C9),
      'Energetic': const Color(0xFFFF8A5C),
      'Sleepy': const Color(0xFF9B9FB5),
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: moods.map((m) {
        return FilterChip(
          label: Text(m),
          selected: false,
          onSelected: (selected) {
            // filter song by mood
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Showing $m songs'),
                backgroundColor: moodColors[m] ?? moodColor.primary,
              ),
            );
          },
          backgroundColor: Colors.grey.withOpacity(0.1),
          selectedColor: (moodColors[m] ?? moodColor.primary).withOpacity(0.2),
          checkmarkColor: moodColors[m] ?? moodColor.primary,
          labelStyle: TextStyle(
            color: moodColors[m] ?? moodColor.primary,
            fontWeight: FontWeight.w500,
          ),
        );
      }).toList(),
    );
  }

  Color _getMoodColor(String? mood) {
    switch (mood) {
      case 'happy':
        return const Color(0xFFFFD93D);
      case 'sad':
        return const Color(0xFF6C9EBF);
      case 'calm':
        return const Color(0xFF8FBC94);
      case 'angry':
        return const Color(0xFFD14D4D);
      case 'anxious':
        return const Color(0xFFB8A9C9);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  void _playSong(BuildContext context, Map<String, dynamic> song, MoodColors moodColor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicPlayerScreen(
          mood: widget.mood,
          primaryColor: moodColor.primary,
          secondaryColor: moodColor.secondary,
          accentColor: moodColor.accent,
          song: {
            'title': song['title'],
            'artist': song['artist'],
            'duration': song['duration'],
          },
        ),
      ),
    );
  }
}
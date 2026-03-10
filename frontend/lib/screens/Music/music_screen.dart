import 'package:flutter/material.dart';
import 'music_playlist_screen.dart';
import 'music_player_screen.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'package:moodsync/widgets/mood_theme.dart';
import 'package:provider/provider.dart';
import 'package:moodsync/provider/mood_provider.dart';

class MusicScreen extends StatefulWidget {
  final String? mood;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;
  
  const MusicScreen({
    super.key,
    required this.mood,
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
  }) ;

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late Color primaryColor;
  late Color secondaryColor;
  late Color accentColor;
  late String mood;

  bool isPlaying = false;
  
  final Map<String, List<Map<String, String>>> moodPlaylists = {
    'happy': [
      {'name': 'Sunshine Vibes', 'songs': '24 songs • 1h 45m'},
      {'name': 'Good Life', 'songs': '28 songs'},
      {'name': 'Party Mix', 'songs': '45 songs'},
    ],
    'sad': [
      {'name': 'Gentle Rain', 'songs': '18 songs • 1h 12m'},
      {'name': 'Melancholy', 'songs': '22 songs'},
      {'name': 'Healing', 'songs': '15 songs'},
    ],
    'angry': [
      {'name': 'Heavy Metal', 'songs': '30 songs • 2h'},
      {'name': 'Release', 'songs': '25 songs'},
      {'name': 'Rock Out', 'songs': '20 songs'},
    ],
    'calm': [
      {'name': 'Ocean Waves', 'songs': '15 songs • 1h'},
      {'name': 'Zen Garden', 'songs': '18 songs'},
      {'name': 'Peaceful Piano', 'songs': '22 songs'},
    ],
    'anxious': [
      {'name': 'Breathe', 'songs': '12 songs • 45m'},
      {'name': 'Calm Down', 'songs': '20 songs'},
      {'name': 'Peace', 'songs': '15 songs'},
    ],
    'frustrated': [
      {'name': 'Let It Go', 'songs': '18 songs • 1h'},
      {'name': 'Release', 'songs': '22 songs'},
      {'name': 'Breathe Out', 'songs': '14 songs'},
    ],
    'surprised': [
      {'name': 'Discovery', 'songs': '25 songs • 1h30m'},
      {'name': 'New Finds', 'songs': '30 songs'},
      {'name': 'Exciting', 'songs': '20 songs'},
    ],
    'neutral': [
      {'name': 'Daily Mix', 'songs': '40 songs • 2h30m'},
      {'name': 'Chill Vibes', 'songs': '35 songs'},
      {'name': 'Background', 'songs': '28 songs'},
    ],
  };

  final Map<String, List<Map<String, String>>> tracklists = {
    'happy': [
      {'title': 'Happy', 'artist': 'Pharrell Williams', 'duration': '3:53'},
      {'title': 'Good Life', 'artist': 'OneRepublic', 'duration': '4:13'},
      {'title': 'Walking On Sunshine', 'artist': 'Katrina & The Waves', 'duration': '3:58'},
      {'title': 'Can\'t Stop The Feeling', 'artist': 'Justin Timberlake', 'duration': '3:56'},
      {'title': 'Uptown Funk', 'artist': 'Bruno Mars', 'duration': '4:30'},
    ],
    'sad': [
      {'title': 'Someone Like You', 'artist': 'Adele', 'duration': '4:45'},
      {'title': 'Fix You', 'artist': 'Coldplay', 'duration': '4:55'},
      {'title': 'Hurt', 'artist': 'Johnny Cash', 'duration': '3:38'},
      {'title': 'Yesterday', 'artist': 'The Beatles', 'duration': '2:05'},
    ],
    'angry': [
      {'title': 'Break Stuff', 'artist': 'Limp Bizkit', 'duration': '2:46'},
      {'title': 'Killing In The Name', 'artist': 'Rage Against The Machine', 'duration': '5:14'},
      {'title': 'Bodies', 'artist': 'Drowning Pool', 'duration': '3:24'},
      {'title': 'Down With The Sickness', 'artist': 'Disturbed', 'duration': '4:38'},
    ],
    'calm': [
      {'title': 'Weightless', 'artist': 'Marconi Union', 'duration': '8:00'},
      {'title': 'Clair de Lune', 'artist': 'Claude Debussy', 'duration': '5:00'},
      {'title': 'Spiegel im Spiegel', 'artist': 'Arvo Pärt', 'duration': '10:00'},
      {'title': 'River Flows In You', 'artist': 'Yiruma', 'duration': '3:30'},
    ],
    'anxious': [
      {'title': 'Breathe Me', 'artist': 'Sia', 'duration': '4:35'},
      {'title': 'Mad World', 'artist': 'Tears for Fears', 'duration': '3:30'},
      {'title': 'Creep', 'artist': 'Radiohead', 'duration': '3:56'},
      {'title': 'Everybody Hurts', 'artist': 'R.E.M.', 'duration': '5:20'},
    ],
    'frustrated': [
      {'title': 'Let It Go', 'artist': 'James Bay', 'duration': '4:15'},
      {'title': 'Release', 'artist': 'Pearl Jam', 'duration': '3:50'},
      {'title': 'Breathe Out', 'artist': 'Linkin Park', 'duration': '3:45'},
      {'title': 'I Will Survive', 'artist': 'Gloria Gaynor', 'duration': '3:18'},
    ],
    'surprised': [
      {'title': 'Discovery', 'artist': 'Daft Punk', 'duration': '3:30'},
      {'title': 'New Finds', 'artist': 'Tame Impala', 'duration': '4:00'},
      {'title': 'Exciting', 'artist': 'MGMT', 'duration': '3:45'},
      {'title': 'Electric Feel', 'artist': 'MGMT', 'duration': '3:50'},
    ],
    'neutral': [
      {'title': 'Daily Mix', 'artist': 'Various Artists', 'duration': '2h30m'},
      {'title': 'Chill Vibes', 'artist': 'Various Artists', 'duration': '1h45m'},
      {'title': 'Background', 'artist': 'Various Artists', 'duration': '1h20m'},
    ],
  };

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 1:
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food screen coming soon!')),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stories screen coming soon!')),
        );
        break;
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Activities screen coming soon!')),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize with provided values or defaults
    primaryColor = widget.primaryColor ?? const Color(0xFFFFD93D);
    secondaryColor = widget.secondaryColor ?? const Color(0xFFFF8A5C);
    accentColor = widget.accentColor ?? const Color(0xFFF9E076);
    mood = widget.mood ?? 'happy';  
  }

  @override
  Widget build(BuildContext context) {
    final mood = Provider.of<MoodProvider>(context).mood;
    final moodColor = MoodTheme.getMoodColors(mood);
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              moodColor.primary.withOpacity(0.15),
              moodColor.secondary.withOpacity(0.10),
              moodColor.accent.withOpacity(0.20),
              Colors.white,
            ],
            stops: const [0.0, 0.3, 0.7,  1.0],
          ),
        ),
        child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black87),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${mood[0].toUpperCase()}${mood.substring(1)} Mood',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.search, color: Colors.black87),
                          const SizedBox(width: 16),
                          const Icon(Icons.more_vert, color: Colors.black87),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            '10:30',
                            style: TextStyle(
                              fontSize: 14,
                              color: moodColor.secondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: moodColor.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Uplifting vibes for you',
                            style: TextStyle(
                              fontSize: 14,
                              color: moodColor.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            moodColor.primary,
                            moodColor.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:moodColor.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      moodPlaylists[mood]?[0]['name'] ?? 'Sunshine Vibes',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      moodPlaylists[mood]?[0]['songs'] ?? '24 songs • 1h 45m',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isPlaying ? Icons.pause : Icons.play_arrow,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isPlaying ? 'PAUSED' : 'PLAY ALL',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'More Playlists',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                          Text(
                            'See All',
                            style: TextStyle(
                              color:accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: moodPlaylists[mood.toLowerCase()]?.length ?? 3,
                        itemBuilder: (context, index) {
                          final playlist = moodPlaylists[mood.toLowerCase()]?[index] ?? {'name': 'Playlist', 'songs': '10 songs'};
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicPlaylistScreen(
                                    mood: mood,
                                    primaryColor: primaryColor,
                                    secondaryColor: secondaryColor,
                                    accentColor: accentColor,
                                    playlistName: playlist['name']!,
                                    playlistDetails: playlist['songs']!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 140,
                              margin: const EdgeInsets.only(right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 140,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: accentColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    playlist['name'] ?? 'Playlist',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    playlist['songs'] ?? '',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'TRACKLIST',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.shuffle,
                            color: accentColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: tracklists[mood.toLowerCase()]?.length ?? 4,
                      itemBuilder: (context, index) {
                        final track = tracklists[mood.toLowerCase()]?[index] ?? 
                            {'title': 'Song $index', 'artist': 'Artist', 'duration': '3:30'};
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicPlayerScreen(
                                  mood: mood,
                                  primaryColor: primaryColor,
                                  secondaryColor: secondaryColor,
                                  accentColor: accentColor,
                                  song: track,
                                ),
                              ),
                            );
                          },
                          child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:accentColor.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      track['title']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      track['artist']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                track['duration']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                            ],
                          ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Currently playing bar at bottom
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                border: Border(
                  top: BorderSide(
                    color: accentColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.music_note, color: primaryColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tracklists[mood]?[0]['title'] ?? 'Happy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: secondaryColor,
                          ),
                        ),
                        Text(
                          tracklists[mood]?[0]['artist'] ?? 'Pharrell Williams',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 28,
                    ),
                    onPressed: () {
                      final currentSong = tracklists[mood]?[0] ??
                          {'title': 'Happy', 'artist': 'Pharrell Williams', 'duration': '3:53'};
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicPlayerScreen(
                            mood: mood,
                            primaryColor: primaryColor,
                            secondaryColor: secondaryColor,
                            accentColor: accentColor,
                            song: currentSong,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          ),
          ),
      ),
      
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        selectedColor: primaryColor,
        onTap: _onNavBarTap,
      ),
    );
  }
}
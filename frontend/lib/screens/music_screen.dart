import 'package:flutter/material.dart';
import 'music_playlist_screen.dart';
import '../widgets/bottom_nav_bar.dart'; 

class MusicScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  
  const MusicScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  }) ;

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool isPlaying = false;
  String currentMood = 'happy'; 
  
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.primaryColor.withOpacity(0.1),
      body: SafeArea(
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
                      '${widget.mood[0].toUpperCase()}${widget.mood.substring(1)} Mood',
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
                        color: widget.secondaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: widget.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Uplifting vibes for you',
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.secondaryColor,
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
                      widget.primaryColor,
                      widget.secondaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.primaryColor.withOpacity(0.3),
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
                                moodPlaylists[widget.mood]?[0]['name'] ?? 'Sunshine Vibes',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                moodPlaylists[widget.mood]?[0]['songs'] ?? '24 songs • 1h 45m',
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
                                color: widget.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isPlaying ? 'PAUSED' : 'PLAY ALL',
                                style: TextStyle(
                                  color: widget.primaryColor,
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
                        color: widget.secondaryColor,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        color: widget.accentColor,
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
                  itemCount: moodPlaylists[widget.mood]?.length ?? 3,
                  itemBuilder: (context, index) {
                    final playlist = moodPlaylists[widget.mood]![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlaylistScreen(
                              mood: widget.mood,
                              primaryColor: widget.primaryColor,
                              secondaryColor: widget.secondaryColor,
                              accentColor: widget.accentColor,
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
                                color: widget.primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: widget.accentColor,
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
                        color: widget.secondaryColor,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.shuffle,
                      color: widget.accentColor,
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
                itemCount: tracklists[widget.mood]?.length ?? 4,
                itemBuilder: (context, index) {
                  final track = tracklists[widget.mood]?[index] ?? 
                      {'title': 'Song $index', 'artist': 'Artist', 'duration': '3:30'};
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: widget.accentColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.secondaryColor,
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
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        selectedColor: widget.primaryColor,
        onTap: _onNavBarTap,
      ),
    );
  }
}
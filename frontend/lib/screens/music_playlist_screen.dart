import 'package:flutter/material.dart';
import 'music_player_screen.dart';

class MusicPlaylistScreen extends StatefulWidget {
  final String mood;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final String playlistName;
  final String playlistDetails;
  
  const MusicPlaylistScreen({
    super.key,
    required this.mood,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.playlistName,
    required this.playlistDetails,
  }) ;

  @override
  State<MusicPlaylistScreen> createState() => _MusicPlaylistScreenState();
}

class _MusicPlaylistScreenState extends State<MusicPlaylistScreen> {
  bool isFollowing = false;
  
  // Sample songs for playlist
  final List<Map<String, String>> playlistSongs = [
    {'title': 'Happy', 'artist': 'Pharrell Williams', 'duration': '3:53', 'popularity': '1'},
    {'title': 'Good Life', 'artist': 'OneRepublic', 'duration': '4:13', 'popularity': '2'},
    {'title': 'Walking On Sunshine', 'artist': 'Katrina & The Waves', 'duration': '3:58', 'popularity': '3'},
    {'title': 'Can\'t Stop The Feeling', 'artist': 'Justin Timberlake', 'duration': '3:56', 'popularity': '4'},
    {'title': 'Uptown Funk', 'artist': 'Bruno Mars', 'duration': '4:30', 'popularity': '5'},
    {'title': 'Shake It Off', 'artist': 'Taylor Swift', 'duration': '3:39', 'popularity': '6'},
    {'title': 'Happy With You', 'artist': 'Paul McCartney', 'duration': '3:34', 'popularity': '7'},
    {'title': 'Best Day Of My Life', 'artist': 'American Authors', 'duration': '3:14', 'popularity': '8'},
    {'title': 'On Top Of The World', 'artist': 'Imagine Dragons', 'duration': '3:12', 'popularity': '9'},
    {'title': 'Firework', 'artist': 'Katy Perry', 'duration': '3:47', 'popularity': '10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.primaryColor.withOpacity(0.1),
      body: CustomScrollView(
        slivers: [
          // App Bar with image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: widget.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.primaryColor,
                      widget.secondaryColor,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.music_note,
                        size: 100,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.playlistName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.playlistDetails,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          
          // Playlist info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: widget.primaryColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: widget.primaryColor.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'PLAY ALL',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: widget.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          Icons.add,
                          color: widget.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          isFollowing ? Icons.favorite : Icons.favorite_border,
                          color: isFollowing ? Colors.red : widget.primaryColor,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            isFollowing = !isFollowing;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.download,
                          color: widget.primaryColor,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Playlist info text
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: widget.accentColor,
                        child: const Text(
                          'M',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'MoodSync • ${playlistSongs.length} songs • 38 min',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Songs list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = playlistSongs[index];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        song['popularity']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    song['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(song['artist']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        song['duration']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerScreen(
                          mood: widget.mood,
                          primaryColor: widget.primaryColor,
                          secondaryColor: widget.secondaryColor,
                          accentColor: widget.accentColor,
                          song: song,
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: playlistSongs.length,
            ),
          ),
        ],
      ),
    );
  }
}
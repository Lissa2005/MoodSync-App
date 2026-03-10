import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget{
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities & Games'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // games section
            const Text(
              'Games',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            //games grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                 _gameCard(
                  context,
                  title: 'Chess',
                  icon: Icons.casino,
                  description: 'Board Game',
                  rating: 4.5,
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                _gameCard(
                  context,
                  title: 'Sudoku',
                  icon: Icons.grid_on,
                  description: 'Puzzle Game',
                  rating: 4.5,
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                _gameCard(
                  context,
                  title: 'Crossword',
                  icon: Icons.abc,
                  description: 'Word Game',
                  rating: 4.5,
                  onTap: () {
                    _showComingSoon(context);
                  },
                ),
                _gameCard(
                  context,
                  title: 'Memory Game',
                  icon: Icons.psychology,
                  description: 'Improve focus and memory',
                  rating: 4.0,
                  onTap: () {
                    _showComingSoon(context);
                    },
                    ),
                _gameCard(
                  context,
                  title: 'Breathing Game',
                  icon: Icons.air,
                  description: 'Relax with guided breathing',
                  rating: 4.5,
                  onTap: () {
                    _showComingSoon(context);
                    },
                    ),
                _gameCard(
                  context,
                  title: 'Mood Quiz',
                  icon: Icons.quiz,
                  description: 'Understand your emotions',
                  rating: 4.0,
                  onTap: () {
                    _showComingSoon(context);
                    },
                    ),
                _gameCard(
                  context,
                  title: 'Puzzle',
                  icon: Icons.extension,
                  description: 'Reduce stress with puzzles',
                  rating: 4.5,
                  onTap: () {
                    _showComingSoon(context);
                    },
                    ),
                    ], 
                    ),

                    const SizedBox(height: 20),

                    //quizzes section
                    const Text(
                      'Quizzes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 16),

                      //quizzes grid
                      _buildQuizCategory(context, 'generalknowledge'),
                      _buildQuizCategory(context, 'science'),
                      _buildQuizCategory(context, 'history'),
                      _buildQuizCategory(context, 'literature'),

                      const SizedBox(height: 30),

                      //reading section
                      const Text(
                        'Reading Materials',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16), 

                      //books section
                      _buildBookCard(
                        title: 'The great Gatsby',
                        genre: 'fiction',
                        rating: 4.5,
                        duration: '5h 30m',
                      ),
                      const SizedBox(height: 12),

                      _buildBookCard(
                        title: 'Sapiens',
                        genre: 'non-fiction',
                        rating: 4.7,
                        duration: '6h 45m',
                      ),
                      const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
 
 //game card widget
  Widget _gameCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required String description,
        required double rating,
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
              Icon(icon, size: 48, color: Colors.blue),
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const  Icon(Icons.star, color: Colors.yellow, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // quiz category widget
  Widget _buildQuizCategory(BuildContext context, String category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () => _showComingSoon(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }

  // book card widget
  Widget _buildBookCard({
    required String title,
    required String genre,
    required double rating,
    required String duration,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.book, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  genre,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor() ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 14,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '· $duration',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
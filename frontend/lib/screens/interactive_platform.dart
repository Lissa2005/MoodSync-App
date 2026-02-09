import 'package:flutter/material.dart';

class InteractivePlatform extends StatefulWidget {
  const InteractivePlatform({super.key});

  @override
  State<InteractivePlatform> createState() => _InteractivePlatformState();
}

class _InteractivePlatformState extends State<InteractivePlatform> {
  final List<String> _stories = [];
  final TextEditingController _storyController = TextEditingController();

  void _addStory() {
    if (_storyController.text.trim().isEmpty) return;

    setState(() {
      _stories.insert(0, _storyController.text.trim());
      _storyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous Stories'),
      ),
      body: Column(
        children: [
          // Story input box
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _storyController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Share your story anonymously...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addStory,
                  child: const Text('Post Anonymously'),
                ),
              ],
            ),
          ),

          const Divider(),

          // Stories list
          Expanded(
            child: _stories.isEmpty
                ? const Center(
              child: Text(
                'No stories yet.\nBe the first to share.',
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text(
                      'Anonymous',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_stories[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        _showCommentDialog(context);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(
            hintText: 'Write a supportive comment...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Comment posted anonymously')),
              );
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}
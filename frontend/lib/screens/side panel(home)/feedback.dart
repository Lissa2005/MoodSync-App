import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _suggestionController = TextEditingController();

  int _rating = 0;

  void _clearAll() {
    _nameController.clear();
    _emailController.clear();
    _feedbackController.clear();
    _suggestionController.clear();
    setState(() {
      _rating = 0;
    });
  }

  void _submitFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thank you for your feedback! 💜')),
    );
    _clearAll();
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
          icon: Icon(
            Icons.star,
            color: index < _rating ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCD6F7),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: const [
                            Icon(Icons.chat_bubble_outline, size: 36),
                            SizedBox(height: 10),
                            Text(
                              "We’d Love Your Feedback!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Help us make MoodSync even better",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        label: 'Your Name',
                        hint: 'Enter your name',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        label: 'Email Address',
                        hint: 'your.email@example.com',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        label: 'Did MoodSync Help You?',
                        hint: 'Tell us how MoodSync made a difference...',
                        controller: _feedbackController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        label: 'Suggestions for Improvements',
                        hint: 'What features would you like to see?',
                        controller: _suggestionController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Rate Your Experience',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      _buildRatingStars(),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _clearAll,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Clear All'),
                          ),
                          ElevatedButton(
                            onPressed: _submitFeedback,
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFC5F0EC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                "Your feedback helps us create better mood experiences! 💜",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    _suggestionController.dispose();
    super.dispose();
  }
}
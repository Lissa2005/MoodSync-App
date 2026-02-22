import 'package:flutter/material.dart';


class Question {
  final String text;
  final String category;
  int score; // 1 to 5
  Question(this.text, this.category, {this.score = 0});
}

class MoodQuizPage extends StatefulWidget {
  const MoodQuizPage({super.key});
  @override
  State<MoodQuizPage> createState() => _MoodQuizPageState();
}

class _MoodQuizPageState extends State<MoodQuizPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Question> _questions = [
    Question("I feel positive and optimistic about my day.", "Happy"),
    Question("I feel motivated to do things I enjoy.", "Happy"),
    Question("I feel low or unhappy without a clear reason.", "Sad"),
    Question("I feel like withdrawing from people or activities.", "Sad"),
    Question("I feel irritated or annoyed easily today.", "Angry"),
    Question("I feel like expressing frustration or anger.", "Angry"),
    Question("I feel relaxed and at ease right now.", "Calm"),
    Question("My thoughts feel steady and under control.", "Calm"),
    Question("I feel worried or nervous about things.", "Anxious"),
    Question("I feel restless or find it hard to relax.", "Anxious"),
    Question("I feel stuck or unable to make progress.", "Frustrated"),
    Question("Small problems feel more overwhelming than usual.", "Frustrated"),
    Question("Something unexpected has strongly affected my mood today.", "Surprised"),
  ];

  void _finishQuiz() {
    Map<String, double> totals = {};
    for (var q in _questions) {
      totals[q.category] = (totals[q.category] ?? 0) + q.score;
    }

    // Calculate averages and find the highest
    String finalMood = "Neutral";
    double highestScore = 0;

    totals.forEach((category, total) {
      double avg = total / (_questions.where((q) => q.category == category).length);
      if (avg > highestScore) {
        highestScore = avg;
        finalMood = category;
      }
    });

    // Neutral Logic: If the highest average is too low (e.g., < 3)
    if (highestScore < 3.0) finalMood = "Neutral";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Mood Result"),
        content: Text("Your dominant mood today is: $finalMood"),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Question ${_currentPage + 1}/${_questions.length}")),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) => setState(() => _currentPage = page),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_questions[index].text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20)),
                        const SizedBox(height: 30),
                        ...List.generate(5, (val) {
                          int scoreValue = val + 1;
                          return RadioListTile<int>(
                            title: Text(_getScoreLabel(scoreValue)),
                            value: scoreValue,
                            groupValue: _questions[index].score,
                            onChanged: (v) => setState(() => _questions[index].score = v!),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton(onPressed: () => _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease), child: const Text("Previous"))
                else
                  const SizedBox.shrink(),
                ElevatedButton(
                  onPressed: () {
                    if (_questions[_currentPage].score == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an answer")));
                      return;
                    }
                    if (_currentPage < _questions.length - 1) {
                      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    } else {
                      _finishQuiz();
                    }
                  },
                  child: Text(_currentPage == _questions.length - 1 ? "Finish" : "Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreLabel(int value) {
    switch (value) {
      case 1: return "Strongly Disagree";
      case 2: return "Disagree";
      case 3: return "Neutral";
      case 4: return "Agree";
      case 5: return "Strongly Agree";
      default: return "";
    }
  }
}
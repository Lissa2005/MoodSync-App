import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _goToSignIn() {
    Navigator.pushReplacementNamed(
      context, '/signin'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToSignIn,
                child: const Text('Skip'),
              ),
            ),

            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                //first page
                children: const [
                  _WelcomePage(
                    title: 'Welcome to MoodSync',
                    description:
                    'Your personal mood companion that understands how you feel.',
                  ),
                  //second page
                  _WelcomePage(
                    title: 'AI-powered Detection',
                    description:
                    'Simply speak or type how you feel and we detect your mood.',
                  ),
                  //Third Page
                  _WelcomePage(
                    title: 'Personalized Everything',
                    description:
                    'Music, food, stories and activities tailored to you.',
                  ),
                  //Forth page
                  _WelcomePage(
                    title: 'Your Private Space',
                    description:
                    'Your moods, your data, your control.',
                  ),
                ],
              ),
            ),

            // Next page + next button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Nextpage(currentPage: _currentPage),

                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == 3) {
                        _goToSignIn();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(_currentPage == 3 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Welcome page widget
class _WelcomePage extends StatelessWidget {
  final String title;
  final String description;

  const _WelcomePage({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //the app logo
          Image.asset(
            'assets/images/app_logo.jpeg',
            height: 220,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _Nextpage extends StatelessWidget {
  final int currentPage;

  const _Nextpage({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
            (index) => Container(
          margin: const EdgeInsets.only(right: 6),
          width: currentPage == index ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? Colors.deepPurple
                : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}


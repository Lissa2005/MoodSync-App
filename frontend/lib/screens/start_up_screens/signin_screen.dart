import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:moodsync/authenticator.dart';
import 'package:moodsync/screens/start_up_screens/signup_screen.dart';


class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xE6843CF4),
              Color(0xFF9269E4),
              Color(0xE6B18DE8),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                // Stingray Logo
                Image.asset(
                  "assets/images/logo_ww.jpeg",
                  height: 120,
                ),

                const SizedBox(height: 30),

                // Glass Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [

                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 25),

                          TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15),
                                backgroundColor: const Color(0xFFA65CC8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                Authenticator.login(
                                  name: '',
                                  email: '',
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen>{
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _emailVerified = false;



  // Mock existing usernames (replace with backend later)
  final List<String> _registeredUsernames = ['admin', 'testuser', 'moodsync'];

  void _nextPage() {
    if (!_formkey.currentState!.validate()) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  //Age check
  void _checkAge() {
    final age = int.tryParse(_ageController.text);

    if (age == null || age < 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are below 12, not eligible to sign up'),
        ),
      );
      return;
    }

    _nextPage();
  }


  double _passwordStrength = 0;
  String _passwordStrengthText = 'Weak';

  void _checkPasswordStrength(String password) {
    double strength = 0;

    if (password.length >= 8) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) strength += 0.25;

    setState(() {
      _passwordStrength = strength;

      if (strength <= 0.25) {
        _passwordStrengthText = 'Weak';
      } else if (strength <= 0.5) {
        _passwordStrengthText = 'Medium';
      } else if (strength <= 0.75) {
        _passwordStrengthText = 'Strong';
      } else {
        _passwordStrengthText = 'Very Strong';
      }
    });
  }


  void _createAccount() {
    if (!_formkey.currentState!.validate()) return;

    if (!_emailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please verify your email')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully')),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              //page 1
            _buildPage(
              title: 'Your Name',
              children:[
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) =>
                  value!.isEmpty ? 'Enter first name' : null,
                ),
                const SizedBox(height: 10),

                // Surname
                TextFormField(
                  controller: _surnameController,
                  decoration: const InputDecoration(labelText: 'Surname'),
                  validator: (value) =>
                  value!.isEmpty ? 'Enter surname' : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: _nextPage, child: const Text ('Next')),
              ],
            ),
            //page 2
            _buildPage(
              title:'Email Address',
              children:[
                //Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter an email';
                    }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emailController.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Verification email sent'),
                              ),
                            );

                            // 🔹 Mock verification success
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _emailVerified = true;
                              });
                            });
                          }
                        },
                        child: const Text('Verify Email'),

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _nextPage, child: const Text ('Next'),
                ),
              ],
            ),

              //page 3
              _buildPage(
                title:'your age',
                children:[
                  // Age
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final age = int.tryParse(value!);
                      if (age == null) return 'Enter a valid age';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: _checkAge , child: const Text('Next'),),
                ],
              ),
                //page 4
                _buildPage(
                  title: 'Choose Username',
                  children: [
                    // Username
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter a username';
                        if (_registeredUsernames.contains(value.toLowerCase())) {
                          return 'Username already taken';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: _nextPage, child: const Text('Next')),
                  ],
                ),
                //Page 5
                _buildPage(
                  title: 'create password',
                  children: [
                  // Password
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onChanged: _checkPasswordStrength,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Strength Meter
                    LinearProgressIndicator(
                      value: _passwordStrength,
                      backgroundColor: Colors.grey[300],
                      color: _passwordStrength <= 0.25
                        ? Colors.red
                        : _passwordStrength <= 0.5
                        ? Colors.orange
                        : _passwordStrength <= 0.75
                        ? Colors.blue
                        : Colors.green,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Password strength: $_passwordStrengthText',
                        style: TextStyle(
                          color: _passwordStrength <= 0.25
                            ? Colors.red
                            : _passwordStrength <= 0.5
                            ? Colors.orange
                            : _passwordStrength <= 0.75
                            ? Colors.blue
                            : Colors.green,
                        ),
                    ),
                    const SizedBox(height: 10),

                    // Confirm Password
                    TextFormField(
                    controller: _confirmPasswordController,
                    decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                    onPressed: _createAccount,
                    child: const Text('Create Account'),
                    ),
                  ],
                ),

            ],
          ),

        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ...children,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
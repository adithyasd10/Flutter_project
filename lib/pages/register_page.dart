import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // Text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Method to show a pop-up dialog
  void showPopup(BuildContext context, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            isSuccess ? 'Success' : 'Error',
            style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Register user method
  void registerUser(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      showPopup(context, 'Passwords do not match', false);
      return;
    }

    try {
      await createUserWithEmailAndPassword();
      Navigator.pushReplacementNamed(context, '/home');
      showPopup(context, 'Registration successful!', true);
    } catch (e) {
      showPopup(context, 'Registration failed: ${e.toString()}', false);
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    print(userCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF), // White
              Color(0xFFE5E5E5), // Light Gray
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Lottie animation above the title
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Lottie.asset(
                      'assets/animations/register_page.json',
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Welcome text
                  const Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Text fields
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    backgroundColor: const Color(0xFFF5F5F5),
                    textColor: Colors.black,
                    borderColor: Colors.grey,
                    borderRadius: 25,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    backgroundColor: const Color(0xFFF5F5F5),
                    textColor: Colors.black,
                    borderColor: Colors.grey,
                    borderRadius: 25,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    backgroundColor: const Color(0xFFF5F5F5),
                    textColor: Colors.black,
                    borderColor: Colors.grey,
                    borderRadius: 25,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    backgroundColor: const Color(0xFFF5F5F5),
                    textColor: Colors.black,
                    borderColor: Colors.grey,
                    borderRadius: 25,
                  ),

                  const SizedBox(height: 25),

                  // Register button
                  MyButton(
                    onTap: () => registerUser(context),
                    text: 'Register',
                    backgroundColor: const Color(0xFF6E7C7C),
                    textColor: Colors.white,
                    borderRadius: 25,
                    shadowColor: Colors.black.withOpacity(0.2),
                  ),

                  const SizedBox(height: 40),

                  // Already have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

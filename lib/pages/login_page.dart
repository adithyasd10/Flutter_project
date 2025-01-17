import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication package
import 'register_page.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'homepage.dart'; // Import HomePage

class LoginPage extends StatelessWidget {
  final String role;

  LoginPage({super.key, required this.role});

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign user in method
  Future<void> signUserIn(BuildContext context) async {
    final email = usernameController.text.trim();
    final password = passwordController.text.trim();

    try {
      // Firebase sign-in logic
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome back, $role! Login successful."),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to HomePage after successful login
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Handle error and display a message
      print("Error code: ${e.code}");
      String errorMessage = '';
      if (e.code == 'invalid-credential') {
        errorMessage = " Incorrect credentials, Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = " Incorrect email, Please try again.";
      } else if (e.code == 'missing-password') {
        errorMessage = "enter a password ";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Handle any other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An unexpected error occurred: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // Welcome animation
                    Lottie.asset(
                      'assets/animations/Animation - 1736879941396.json',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(height: 30),

                    // Welcome message based on role
                    Text(
                      role == 'student'
                          ? 'Welcome back, dear Student!'
                          : 'Welcome back, respected Teacher!',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    // Username textfield
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

                    // Password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      backgroundColor: const Color(0xFFF5F5F5),
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      borderRadius: 25,
                    ),

                    const SizedBox(height: 10),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Sign in button
                    MyButton(
                      onTap: () => signUserIn(context),
                      text: 'Sign In',
                      backgroundColor: const Color(0xFF6E7C7C),
                      textColor: Colors.white,
                      borderRadius: 25,
                      shadowColor: Colors.black.withOpacity(0.2),
                    ),

                    const SizedBox(height: 40),

                    // Or continue with
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Google + Apple sign in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // Google button
                        SquareTile(imagePath: 'lib/images/google.png'),
                        SizedBox(width: 25),
                        // Apple button
                        SquareTile(imagePath: 'lib/images/apple.png'),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Not a member? Register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        RegisterPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Register now',
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
      ),
    );
  }
}

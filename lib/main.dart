import 'package:flutter/material.dart';
import 'package:projects/components/splash_screen.dart';
import './components/student_teacher.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart'; // Import the RegisterPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/student_teacher': (context) => const StudentTeacherPage(),
        '/login': (context) => LoginPage(role: '',),
        '/register': (context) =>  RegisterPage(), // Add RegisterPage route
      },
    );
  }
}

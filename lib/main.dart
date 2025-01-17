import 'package:flutter/material.dart';
import 'package:projects/components/splash_screen.dart';
import './components/student_teacher.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/homepage.dart'; // Import the HomePage
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/login': (context) => LoginPage(
              role: '',
            ),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(), // New route for HomePage
      },
    );
  }
}

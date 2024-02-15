import 'package:attendance_app/screens/clock_page.dart';
import 'package:attendance_app/screens/home_page.dart';
import 'package:attendance_app/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/clock': (context) => ClockPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

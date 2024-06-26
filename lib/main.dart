import 'package:attendance_app/providers/attendances_list_provider.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/providers/location_provider.dart';
import 'package:attendance_app/providers/server_time_provider.dart';
import 'package:attendance_app/screens/clock_page.dart';
import 'package:attendance_app/screens/home_page.dart';
import 'package:attendance_app/screens/login_page.dart';
import 'package:attendance_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ServerTimeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AttendanceListProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LocationProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Provider.of<AuthProvider>(context, listen: false).logout();
    return FutureBuilder<bool>(
      future: Provider.of<AuthProvider>(context, listen: false).isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.primaryColor,
                  CustomColors.secondaryColor,
                ],
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else {
          final isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            title: 'Attendance App',
            debugShowCheckedModeBanner: false,
            initialRoute: isLoggedIn ? '/home' : '/login',
            routes: {
              '/home': (context) => const HomePage(),
              '/clock': (context) => const ClockPage(),
              '/login': (context) => const LoginPage(),
            },
          );
        }
      },
    );
  }
}

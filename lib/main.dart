import 'package:attendance_app/providers/attendances_list_provider.dart';
import 'package:attendance_app/providers/auth_provider.dart';
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
      )
    ],
    child: MyApp(),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.primaryColor,
                  CustomColors.secondaryColor,
                ],
              ),
            ),
            child: Center(
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
              '/home': (context) => HomePage(),
              '/clock': (context) => ClockPage(),
              '/login': (context) => LoginPage(),
            },
          );
        }
      },
    );
  }
}

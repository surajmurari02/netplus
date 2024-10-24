import 'package:flutter/material.dart';
// import 'package:intel_eye/views/screens/extended_view.dart';
import 'package:intel_eye/views/screens/home_screen.dart';
import 'package:intel_eye/views/screens/login_page.dart';
import 'package:intel_eye/views/screens/splash_screen.dart';
import 'package:intel_eye/themes/theme.dart'; // Correct import for the theme file

void main() {
  runApp(const IntelEye());
}

class IntelEye extends StatelessWidget {
  const IntelEye({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme, // Use the theme defined in theme.dart
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        // ExtendedView.routeName: (context) => const ExtendedView(),
      },
    );
  }
}

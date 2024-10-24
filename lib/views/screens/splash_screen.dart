import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intel_eye/views/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer; // Timer variable to manage timer lifecycle

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.25,
              height: width * 0.25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/logo/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Net+ Secure",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Powered by: Samajh.ai"),
        ],
      ),
    );
  }
}

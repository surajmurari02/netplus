import 'package:flutter/material.dart';
import 'package:intel_eye/views/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login'; // Route name

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.red, Colors.white], // Updated gradient colors
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _icon(),
                const SizedBox(height: 50),
                _inputField("Username", _usernameController),
                const SizedBox(height: 20),
                _inputField("Password", _passwordController, isPassword: true),
                const SizedBox(height: 50),
                _loginButton(context),
                const SizedBox(height: 20),
                _extraText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 100,
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.red), // Updated text color
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.redAccent), // Updated hint text color
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red), // Updated focused border color
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Check if demo credentials are correct
        if (_usernameController.text == 'samajhai' &&
            _passwordController.text == '12345678') {
          Navigator.popAndPushNamed(context, HomeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid credentials. Try again."),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.red, // Updated button background color
        foregroundColor: Colors.white, // Updated button text color
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign in",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _extraText() {
    return const Text(
      "Can't access your account?",
      style: TextStyle(color: Colors.white70, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}

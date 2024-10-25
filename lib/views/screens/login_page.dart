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
          colors: [Colors.red, Colors.white], // Red and white gradient
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _icon(),
                  const SizedBox(height: 40),
                  _inputField("Username", _usernameController),
                  const SizedBox(height: 20),
                  _inputField("Password", _passwordController, isPassword: true),
                  const SizedBox(height: 40),
                  _loginButton(context),
                  const SizedBox(height: 20),
                  _extraText(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Powered by: Samajh.ai",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_pin_outlined,
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
      style: const TextStyle(color: Colors.red, fontSize: 18), // Red input text
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.redAccent), // Red hint text
        filled: true,
        fillColor: Colors.white.withOpacity(0.9), // White background for input fields
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_usernameController.text == 'netplus' &&
            _passwordController.text == 'netplus@123') {
          Navigator.popAndPushNamed(context, HomeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid credentials. Try again."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.red, // Red button color
        foregroundColor: Colors.white, // White text color
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
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
      style: TextStyle(color: Color.fromARGB(179, 152, 29, 29), fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}

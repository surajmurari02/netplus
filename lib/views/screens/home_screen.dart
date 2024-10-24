import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:intel_eye/utils/camera_data.dart';
import 'package:intel_eye/views/widgets/camera_card.dart';
import 'package:intel_eye/api_service.dart'; // Import ApiService

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initial switch state (true = ON, false = OFF)
  bool switchState = true;

  final ApiService apiService = ApiService(); // Create instance of ApiService

  // Function to toggle the switch and send API request
  Future<void> toggleSwitch() async {
    try {
      // Call API with the current switch state
      await apiService.toggleSwitch(switchState);

      // Update the switch state in the UI
      setState(() {
        switchState = !switchState;
      });
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        actions: [
          const Text(
            "Net+ Secure",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
          ),
          const SizedBox(width: 20),
        ],
        leading: const Icon(Icons.menu_rounded),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Camera"),
                    ),
                    Text("Notification"),
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Toggle Button for Light (Switch)
                    GestureDetector(
                      onTap: toggleSwitch, // Call the toggle function on tap
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            switchState ? Icons.lightbulb : Icons.lightbulb_outline,
                          ),
                          const Text("Light"),
                        ],
                      ),
                    ),
                    const Text("Alarm"),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cameraData.length,
              itemBuilder: (ctx, index) {
                return CameraCard(
                  camera: cameraData[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

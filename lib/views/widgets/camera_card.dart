import 'package:flutter/material.dart';
import 'package:intel_eye/api_service.dart'; // Import your ApiService

class CameraCard extends StatefulWidget {
  const CameraCard({super.key, required this.camera});
  final String camera;

  @override
  State<CameraCard> createState() => _CameraCardState();
}

class _CameraCardState extends State<CameraCard> {
  // Initial states for switches
  bool lightButton = true;
  bool alarmButton = true;

  // Create an instance of the ApiService to interact with the API
  final ApiService apiService = ApiService();

  // Method to toggle light switch and call the API
  void _toggleLightSwitch(bool newState) async {
    setState(() {
      lightButton = newState; // Update UI state immediately
    });

    try {
      await apiService.toggleSwitch(newState); // Call the API with the new state
      print('Light switch toggled successfully');
    } catch (e) {
      print('Failed to toggle light switch: $e');
    }
  }

  // Method to toggle alarm switch (optional for additional functionality)
  void _toggleAlarmSwitch(bool newState) async {
    setState(() {
      alarmButton = newState; // Update UI state immediately
    });

    try {
      await apiService.toggleSwitch(newState); // Call the API with the new state
      print('Alarm switch toggled successfully');
    } catch (e) {
      print('Failed to toggle alarm switch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigate to ExtendedView with camera data
        Navigator.pushNamed(
          context,
          '/extendedView', // Ensure this route is defined
          arguments: {"cam": widget.camera},
        );
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                        "assets/img/camera_view${widget.camera}.png"),
                    height: 50,
                  ),
                  const Text("_"), // Placeholder content
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Light Switch
                  Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: lightButton,
                      onChanged: (bool val) {
                        _toggleLightSwitch(val); // Call the toggle method
                      },
                    ),
                  ),
                  // Alarm Switch
                  Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: alarmButton,
                      onChanged: (bool val) {
                        _toggleAlarmSwitch(val); // Optional alarm toggle
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

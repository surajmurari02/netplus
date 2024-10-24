import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // For jsonEncode
import 'package:intel_eye/utils/camera_data.dart';
import 'package:intel_eye/views/widgets/camera_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initial switch state (can be true for 1 or false for 0)
  bool switchState = true;

  // Function to toggle the switch
  Future<void> toggleSwitch() async {
    final deviceId = 'A001';
    final newState = switchState ? 0 : 1; // Toggle state
    final url = 'http://20.219.219.69:8078/apiv2/changestatus';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'device_id': deviceId, 'value': newState}),
      );

      if (response.statusCode == 200) {
        // Optionally update the local switch state
        setState(() {
          switchState = !switchState; // Toggle the switch state
        });
      } else {
        // Handle error response
        print('Error: ${response.body}');
      }
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
          Text(
            "Net+ Secure",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
          ),
          SizedBox(width: 20),
        ],
        leading: Icon(Icons.menu_rounded),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
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
                      onTap: toggleSwitch, // Call the toggle function
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(switchState ? Icons.lightbulb : Icons.lightbulb_outline),
                          Text("Light"),
                        ],
                      ),
                    ),
                    Text("Alarm"),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
          Divider(),
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

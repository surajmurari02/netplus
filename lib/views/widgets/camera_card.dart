import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'package:intel_eye/api_service.dart'; // Import ApiService
import 'package:logger/logger.dart'; // Logger for debugging

class CameraCard extends StatefulWidget {
  const CameraCard({super.key, required this.camera});
  final String camera;

  @override
  State<CameraCard> createState() => _CameraCardState();
}

class _CameraCardState extends State<CameraCard> {
  bool lightButton = true; // Initial state for the light switch
  bool alarmButton = true; // Initial state for the alarm switch
  final ApiService apiService = ApiService(); // Instance of ApiService
  final Logger logger = Logger(); // Logger instance

  // Image URL that refreshes periodically
  String imageUrl = 'http://20.219.219.69:8078/apiv2/evidence/image/images.jpeg';
  Timer? _imageRefreshTimer; // Timer for refreshing the image

  @override
  void initState() {
    super.initState();
    _startImageRefreshTimer(); // Start the timer on widget initialization
  }

  @override
  void dispose() {
    _imageRefreshTimer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  // Start a periodic timer to refresh the image URL every 2 seconds
  void _startImageRefreshTimer() {
    _imageRefreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        setState(() {
          // Append a timestamp to the URL to prevent caching
          imageUrl =
              'http://20.219.219.69:8078/apiv2/evidence/image/images.jpeg?timestamp=${DateTime.now().millisecondsSinceEpoch}';
        });

        // Log the refresh action to verify periodic execution
        logger.d('Image refreshed at: ${DateTime.now()}');
      },
    );
  }

  // Toggle light switch and call the API
  void _toggleLightSwitch(bool newState) async {
    setState(() {
      lightButton = newState;
    });

    try {
      await apiService.toggleSwitch(newState);
      print('Light switch toggled successfully');
    } catch (e) {
      print('Failed to toggle light switch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Handle tap for extended view or navigation
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
                  // Display the dynamic image with specific dimensions
                  Image.network(
                    imageUrl,
                    width: 100, // Set desired width
                    height: 100, // Set desired height
                    fit: BoxFit.cover, // Ensure the image fits within the container
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                      ); // Display icon on load error
                    },
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
                        _toggleLightSwitch(val); // Call toggle method on change
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

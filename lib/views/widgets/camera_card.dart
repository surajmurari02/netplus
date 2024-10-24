import 'package:flutter/material.dart';
import 'package:intel_eye/api_service.dart'; // Import your ApiService
import 'package:intel_eye/views/screens/extended_view.dart';

class CameraCard extends StatefulWidget {
  const CameraCard({super.key, required this.camera});
  final String camera;

  @override
  State<CameraCard> createState() => _CameraCardState();
}

class _CameraCardState extends State<CameraCard> {
  bool lightButton = true;
  bool alarmButton = true;

  final ApiService apiService = ApiService(); // Create an instance of ApiService

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ExtendedView.routeName,
            arguments: {"cam": widget.camera});
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
        margin: EdgeInsets.all(15),
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
                    Text("_"),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: lightButton,
                        onChanged: (bool val) {
                          setState(() {
                            lightButton = val;
                          });
                          apiService.toggleSwitch("light", lightButton); // Call the API service method
                        },
                      ),
                    ),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: alarmButton,
                        onChanged: (val) {
                          setState(() {
                            alarmButton = val;
                          });
                          apiService.toggleSwitch("alarm", val); // Call the API service method
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intel_eye/views/widgets/camera_notification.dart';

class ExtendedView extends StatelessWidget {
  static const String routeName = '/extendedView';
  const ExtendedView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                image: AssetImage("assets/img/camera_view${args['cam']}.png")),
            SizedBox(
              height: 20,
            ),
            Text("Notifications"),
            Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                itemBuilder: (ctx, index) {
                  return CameraNotification(
                    notification: "Camera Notification ${index + 1}",
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration: BoxDecoration(color: Colors.grey),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

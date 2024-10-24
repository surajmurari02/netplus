import 'package:flutter/material.dart';

class CameraNotification extends StatelessWidget {
  final String notification;
  const CameraNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(notification),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.check_rounded)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded))
                ],
              ))
        ],
      ),
    );
  }
}

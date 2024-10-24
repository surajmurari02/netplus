import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://20.219.219.69:8078/apiv2/changestatus';
  final String deviceId = 'A001';

  Future<void> toggleSwitch(String switchType, bool isOn) async {
  String devStatus = isOn ? '1' : '0';
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'dev_status': devStatus,
      'device_id': deviceId,
    }),
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode == 200) {
    print('Switch toggled successfully: ${response.body}');
  } else {
    print('Failed to toggle switch: ${response.statusCode}');
  }
}
}


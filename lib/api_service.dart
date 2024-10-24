import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

class ApiService {
  // API call to toggle the switch
  Future<void> toggleSwitch(bool isOn) async {
    final String devStatus = isOn ? '1' : '0';
    final String apiUrl = 'http://20.219.219.69:8078/apiv2/changestatus';
    final String deviceId = 'A001';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // Optional, based on API needs
        },
        body: jsonEncode({
          'dev_status': devStatus,
          'device_id': deviceId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Switch toggled successfully.');
      } else {
        print('Failed to toggle switch: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}

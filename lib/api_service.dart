import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert'; // For JSON encoding

class ApiService {
  final Logger logger = Logger(); // Logger instance

  // API call to toggle the switch
  Future<void> toggleSwitch(bool isOn) async {
    logger.d("Logger is working!");

    final String devStatus = isOn ? '1' : '0';
    final String apiUrl = 'http://20.219.219.69:8078/apiv2/changestatus';
    final String deviceId = 'A001';

    // Prepare request body and headers
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'dev_status': devStatus,
      'device_id': deviceId,
    };

    try {
      // Log the request details
      logger.i("Sending API Request to $apiUrl");
      logger.i("Request Headers: $headers");
      logger.i("Request Body: ${jsonEncode(requestBody)}");

      // Send the HTTP POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Log the response status and body
      logger.i("Response Status: ${response.statusCode}");
      logger.i("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        logger.i("Switch toggled successfully.");
      } else {
        logger.w("Failed to toggle switch. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      // Log any exceptions that occur during the request
      logger.e("Exception occurred: $e");
    }
  }
}

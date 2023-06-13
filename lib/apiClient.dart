import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String baseUrl = 'https://realty-api.nxgeninventors.com/api';

  Future<http.Response> getRequest(String path) async {
    final url = '$baseUrl/$path';
    final response = await http.get(Uri.parse(url));
    return response;
  }

  Future<http.Response> postRequest(String path, Map<String, dynamic> body) async {
    final url = '$baseUrl/$path';
    print('Response url: $url}');

    String requestBodyJson = jsonEncode(body);

    final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'// Set the Content-Type header to application/json
        },
        body: requestBodyJson);
    print('Response body: ${response.body}');

    return response;
  }

// Add more methods for different HTTP methods as per your requirements
}

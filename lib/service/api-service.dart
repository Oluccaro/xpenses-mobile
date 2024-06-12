import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    return response;
  }

  Future<http.Response> postRequest(String endpoint, Map<String, dynamic> jsonBody) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );

    return response;
  }

  Future<http.Response> putRequest(String endpoint, Map<String, dynamic> jsonBody) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );

    return response;
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  }
}

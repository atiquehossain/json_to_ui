import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String url;
  final Map<String, String>? headers;

  NetworkService({required this.url, this.headers});

  Future<bool> hasInternetConnection() async {
    try {
      // Send a lightweight HTTP HEAD request to a reliable server.
      final response = await http.head(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>> get() async {
    if (!await hasInternetConnection()) {
      return {'error': 'No internet connection'};
    }

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      return _processResponse(response);
    } on TimeoutException {
      return {'error': 'Request timed out'};
    } catch (e) {
      return {'error': 'An unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> post(Map<String, dynamic> body) async {
    if (!await hasInternetConnection()) {
      return {'error': 'No internet connection'};
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _addDefaultHeaders(headers),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } on TimeoutException {
      return {'error': 'Request timed out'};
    } catch (e) {
      return {'error': 'An unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> put(Map<String, dynamic> body) async {
    if (!await hasInternetConnection()) {
      return {'error': 'No internet connection'};
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: _addDefaultHeaders(headers),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } on TimeoutException {
      return {'error': 'Request timed out'};
    } catch (e) {
      return {'error': 'An unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> delete() async {
    if (!await hasInternetConnection()) {
      return {'error': 'No internet connection'};
    }

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      return _processResponse(response);
    } on TimeoutException {
      return {'error': 'Request timed out'};
    } catch (e) {
      return {'error': 'An unexpected error occurred'};
    }
  }

  // Helper to process the HTTP response
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP request failed with status: ${response.statusCode}');
    }
  }

  // Add default headers (e.g., Content-Type)
  Map<String, String> _addDefaultHeaders(Map<String, String>? customHeaders) {
    final defaultHeaders = {
      'Content-Type': 'application/json',
    };
    if (customHeaders != null) {
      defaultHeaders.addAll(customHeaders);
    }
    return defaultHeaders;
  }
}

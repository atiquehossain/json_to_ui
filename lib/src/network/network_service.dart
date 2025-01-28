import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkService {
  final String url;
  final Map<String, String>? headers;

  NetworkService({required this.url, this.headers});

  Future<Map<String, dynamic>> get() async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _mergedHeaders,
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  Future<Map<String, dynamic>> post(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _mergedHeaders,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }
  }

  Map<String, String> get _mergedHeaders {
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return {...defaultHeaders, ...?headers};
  }

/*  Future<Map<String, dynamic>> put(Map<String, dynamic> body) async {
    if (!await hasInternetConnection()) {
      print("Connection Error: No internet connection");
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
      print("Connection Error: Request timed out");
      return {'error': 'Request timed out'};
    } catch (e) {
      print("Error: $e");
      return {'error': 'An unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> delete() async {
    if (!await hasInternetConnection()) {
      print("Connection Error: No internet connection");
      return {'error': 'No internet connection'};
    }

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      return _processResponse(response);
    } on TimeoutException {
      print("Connection Error: Request timed out");
      return {'error': 'Request timed out'};
    } catch (e) {
      print("Error: $e");
      return {'error': 'An unexpected error occurred'};
    }
  }*/
}
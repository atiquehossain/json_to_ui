import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service class to handle network operations such as GET and POST requests.
class NetworkService {
  final String url;
  final Map<String, String>? headers;

  /// Constructor to initialize the `NetworkService` with a URL and optional headers.
  ///
  /// [url] is the endpoint URL for the network request.
  /// [headers] are the optional headers to be added to the requests.
  NetworkService({required this.url, this.headers});

  /// Checks whether the device has an active internet connection by sending a HEAD request
  /// to a known server (Google).
  ///
  /// Returns `true` if the device has an internet connection, otherwise `false`.
  Future<bool> hasInternetConnection() async {
    try {
      final response = await http.head(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Performs a GET request to the provided URL and returns the response as a decoded map.
  ///
  /// If the internet connection is not available, it returns an error message in the form of a map.
  /// Catches `TimeoutException` and general exceptions to handle errors gracefully.
  ///
  /// Returns a map containing the response data or an error message.
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

  /// Performs a POST request to the provided URL with the given body and returns the response
  /// as a decoded map.
  ///
  /// If the internet connection is not available, it returns an error message in the form of a map.
  /// Catches `TimeoutException` and general exceptions to handle errors gracefully.
  ///
  /// [body] is the JSON-encoded data to send in the body of the POST request.
  ///
  /// Returns a map containing the response data or an error message.
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

  /// Processes the response from an HTTP request.
  ///
  /// If the status code is 200 (OK), it returns the decoded JSON response as a map.
  /// If the status code is not 200, it throws an exception.
  ///
  /// [response] is the HTTP response to process.
  ///
  /// Returns the decoded JSON response if the request was successful.
  /// Throws an exception if the request failed.
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'HTTP request failed with status: ${response.statusCode}');
    }
  }

  /// Adds default headers to the request and merges with any custom headers.
  ///
  /// [customHeaders] are the optional headers to be merged with the default headers.
  ///
  /// Returns a map containing the default headers merged with the custom headers.
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

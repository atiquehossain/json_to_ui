/// An enumeration representing HTTP methods used for network requests.
enum Method { get, post }

/// This class is responsible for defining the configuration of a network request.
///
/// It encapsulates the details required to perform a network request such as
/// the URL, HTTP method, optional request body, and headers.
class NetworkRequest {
  /// The URL to which the request will be sent.
  final String url;

  /// The HTTP method to be used for the request (e.g., GET, POST).
  final Method method;

  /// The optional request body to be sent with POST requests.
  /// For GET requests, this value will typically be `null`.
  final Map<String, dynamic>? body;

  /// The optional headers to include in the request.
  final Map<String, String>? headers;

  /// Constructs a [NetworkRequest] instance with the given parameters.
  ///
  /// [url] is the target endpoint of the network request.
  /// [method] is the HTTP method to be used (GET or POST).
  /// [body] is the optional request body (usually used for POST requests).
  /// [headers] is the optional set of headers to be included in the request.
  const NetworkRequest({
    required this.url,
    required this.method,
    this.body,
    this.headers,
  });
}

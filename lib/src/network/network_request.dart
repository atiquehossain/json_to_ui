enum Method { get, post }

class NetworkRequest {
  final String url;
  final Method method;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;

  const NetworkRequest({
    required this.url,
    required this.method,
    this.body,
    this.headers,
  });
}
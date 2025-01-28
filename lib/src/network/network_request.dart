enum Method { get, post, put, delete }

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
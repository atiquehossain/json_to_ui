import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../network/network_request.dart';
import '../network/network_service.dart';
import '../storage/hive_service.dart';
import 'ui_builder.dart';

class JsonNetworkUiBuilder extends StatelessWidget {
  final NetworkRequest request;
  final bool isSaveOnHive;

  const JsonNetworkUiBuilder.fromNetwork({
    required this.request,
    this.isSaveOnHive = false,
    super.key,
  });

  /// Checks whether there is an active internet connection by attempting to send
  /// an HTTP HEAD request to Google's homepage.
  ///
  /// Returns `true` if the internet connection is active (response status is 200),
  /// otherwise returns `false`.
  Future<bool> hasInternetConnection() async {
    try {
      final response = await http.head(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  /// Fetches JSON data from a remote server or returns cached data if the device
  /// is offline and the data has been previously cached.
  ///
  /// This method will perform the following steps:
  /// 1. Check for an active internet connection.
  /// 2. If online, fetch the data using either GET or POST method as specified in [request].
  /// 3. Optionally save the fetched data to Hive if [isSaveOnHive] is `true`.
  /// 4. If offline and data is available in the cache (Hive), return the cached data.
  /// 5. Throws an exception if no internet connection is available and no cached data exists.
  ///
  /// [request] The network request configuration that includes the URL, HTTP method, body, and headers.
  /// [isSaveOnHive] A flag indicating whether to save the fetched data to Hive storage.
  Future<Map<String, dynamic>> fetchJson() async {
    final networkService = NetworkService(url: request.url);
    final hiveService = HiveService();

    // Initialize Hive service for local storage.
    await hiveService.init();

    // Check internet connection status.
    final hasInternet = await hasInternetConnection();

    if (hasInternet) {
      try {
        Map<String, dynamic> response;

        // Perform the appropriate network request based on the method (GET or POST).
        switch (request.method) {
          case Method.get:
            response = await networkService.get();
            break;
          case Method.post:
            response = await networkService.post(request.body ?? {});
            break;
        }

        // If saving to Hive is enabled, store the data locally.
        if (isSaveOnHive) {
          await hiveService.saveData(request.url, response);
        }

        return response;
      } catch (error) {
        throw Exception('Failed to load JSON: $error');
      }
    } else {
      // Attempt to fetch cached data if no internet connection is available.
      final cachedData = hiveService.getData(request.url);
      if (cachedData != null) {
        return cachedData;
      }
      throw Exception('No cached data available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return UIBuilder.parseJson(snapshot.data!);
        }
        return const Center(child: Text('No data found.'));
      },
    );
  }
}

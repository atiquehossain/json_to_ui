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
  Future<bool> hasInternetConnection() async {
    try {
      final response = await http.head(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchJson() async {
    final networkService = NetworkService(url: request.url);
    final hiveService = HiveService();

    await hiveService.init();

    final hasInternet = await hasInternetConnection();

    if (hasInternet) {
      try {
        Map<String, dynamic> response;
        switch (request.method) {
          case Method.get:
            response = await networkService.get();
            break;
          case Method.post:
            response = await networkService.post(request.body ?? {});
            break;
        /* case Method.put:
            response = await networkService.put(request.body ?? {});
            print("PUT response: $response");
            break;
          case Method.delete:
            response = await networkService.delete();
            print("DELETE response: $response");
            break;*/
          default:
            throw Exception('Unsupported HTTP method: ${request.method}');
        }

        if (isSaveOnHive) {
          await hiveService.saveData(request.url, response);
        }

        return response;
      } catch (error) {
        throw Exception('Failed to load JSON: $error');
      }
    } else {
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
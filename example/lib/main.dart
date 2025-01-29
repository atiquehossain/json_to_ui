import 'package:flutter/material.dart';
import 'package:json_to_ui/json_to_ui.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JsonNetworkUiBuilder.fromNetwork(
        request: NetworkRequest(
          url:
              'https://raw.githubusercontent.com/atiquehossain/testjson/refs/heads/main/testservermain.json',
          method: Method.get,
        ),
        isSaveOnHive: true,
      ),
    );
  }
}

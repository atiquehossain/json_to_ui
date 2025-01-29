import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_to_ui/json_to_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: JsonNetworkUiBuilder.fromNetwork(
          request: NetworkRequest(
            url: 'https://raw.githubusercontent.com/atiquehossain/testjson/refs/heads/main/testservermain.json',
            method: Method.get,
          ),
          isSaveOnHive: true,
        ),
      ),
    );
  }
}
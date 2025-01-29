import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final String boxName;

  HiveService({this.boxName = 'cachedData'});

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      if (!Hive.isAdapterRegistered(0)) {
        await Hive.initFlutter();
      }
      await Hive.openBox(boxName);
    }
  }

  Future<void> saveData(String key, Map<String, dynamic> data) async {
    final box = Hive.box(boxName);
    await box.put(key, jsonEncode(data)); // Encode to JSON string
  }

  Map<String, dynamic>? getData(String key) {
    final box = Hive.box(boxName);
    final dataString = box.get(key) as String?; // Retrieve as String
    if (dataString != null) {
      return jsonDecode(dataString) as Map<String, dynamic>; // Decode to Map
    } else {
      return null;
    }
  }

  List<String> getAllKeys() {
    final box = Hive.box(boxName);
    return box.keys.cast<String>().toList();
  }

  Future<void> clearData() async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}

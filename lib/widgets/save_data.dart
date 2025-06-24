import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// zapisanie danych
Future<void> saveData(List<Map<String, dynamic>> items) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(items);
  await prefs.setString('exercise_items', jsonString);
}

// odczyt danych
Future<List<Map<String, dynamic>>> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('exercise_items');
  if (jsonString == null) return [];
  final List decoded = jsonDecode(jsonString);
  return decoded.cast<Map<String, dynamic>>();
}
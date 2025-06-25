import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:myapp/data/dataset_model.dart'; // adjust path as needed

Future<void> saveExercises(List<Exercise> exercises) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(exercises.map((e) => e.toJson()).toList());
  await prefs.setString('exercise_data', jsonString);
}

Future<List<Exercise>> loadExercises() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('exercise_data');
  if (jsonString == null) return [];
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((e) => Exercise.fromJson(e)).toList();
}
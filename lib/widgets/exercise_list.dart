import 'package:flutter/material.dart';
import 'exercise_data.dart';
import 'package:myapp/data/dataset_model.dart';
import 'package:myapp/data/dataset_functionality.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExerciseList());
  }
}

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  List<Exercise> _exercises = []; //dataset
  //final List<Map<String, dynamic>> _items = [
  //  // {'icon': Icons.map, 'text': 'Map'},
  //  // {'icon': Icons.photo_album, 'text': 'Album'},
  //  // {'icon': Icons.phone, 'text': 'Phone'},
  //];
  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  void _loadExercises() async {
    final data = await loadExercises();
    setState(() {
      _exercises = data;
    });
  }

  final TextEditingController _textController = TextEditingController();

  // final Map<String, List<SetData>> _exerciseHistories = {};

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add a new exercise'),
            content: TextField(
              controller: _textController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Exercise name',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = _textController.text.trim();
                  if (name.isNotEmpty) {
                    //tu zmieniem żeby plusik dodawał do datasetu
                    setState(() {
                      _exercises.add(Exercise(name: name, sets: []));
                    });
                    saveExercises(_exercises);
                    _textController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
    );
  }

  void _confirmDeleteExercise(int index) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirm deletion'),
            content: const Text('Are you sure you want to delete this exercise?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    _exercises.removeAt(index);
                    saveExercises(_exercises);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }

  void _navigateToDetails(Exercise exercise) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ExerciseDetailPage(exercise: exercise)),
    );
    // Save after returning from detail page to persist any edits
    saveExercises(_exercises);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Exercises')),
      body: ListView.builder(
        itemCount: _exercises.length, // Use your loaded list here
        itemBuilder: (context, index) {
          final item = _exercises[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: const Icon(Icons.fitness_center, size: 30),
              title: Text(item.name),
              onTap:
                  () => _navigateToDetails(item), // Pass full Exercise object
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDeleteExercise(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.amber,
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add, color: Colors.black, size: 32.0),
      ),
    );
  }
}

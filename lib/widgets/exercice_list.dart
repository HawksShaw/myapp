import 'package:flutter/material.dart';
import 'exercise_data.dart';
import 'package:myapp/data/dataset_model.dart';
import 'package:myapp/data/dataset_functionality.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExerciceList());
  }
}

class ExerciceList extends StatefulWidget {
  const ExerciceList({super.key});

  @override
  State<ExerciceList> createState() => _ExerciceListState();
}

class _ExerciceListState extends State<ExerciceList> {
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
            title: const Text('Dodaj nowe ćwiczenie'),
            content: TextField(
              controller: _textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Nazwa ćwiczenia'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Anuluj'),
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
                child: const Text('Dodaj'),
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
            title: const Text('Potwierdź usunięcie'),
            content: const Text('Czy na pewno chcesz usunąć to ćwiczenie?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Anuluj'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    _exercises.removeAt(index);
                    saveExercises(_exercises);
                  });
                  
                },
                child: const Text('Usuń'),
              ),
            ],
          ),
    );
  }

  void _navigateToDetails(Exercise exercise) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ExerciseDetailPage(exercise: exercise),
    ),
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
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

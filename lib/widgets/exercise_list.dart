import 'package:flutter/material.dart';
import 'exercise_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExerciseList(),
    );
  }
}

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  
  final List<Map<String, dynamic>> _items = [
    // {'icon': Icons.map, 'text': 'Map'},
    // {'icon': Icons.photo_album, 'text': 'Album'},
    // {'icon': Icons.phone, 'text': 'Phone'},
  ];

  final TextEditingController _textController = TextEditingController();

  // final Map<String, List<SetData>> _exerciseHistories = {};

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              style: TextStyle(color: Colors.amber),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _textController.text.trim();
              if (name.isNotEmpty) {
                setState(() => _items.add({
                      'icon': Icons.fitness_center,
                      'text': name,
                    }));
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
      builder: (_) => AlertDialog(
        title: const Text('Confirm delete'),
        content: const Text('Are you sure you want to delete this exercise?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.amber),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => _items.removeAt(index));
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

  void _navigateToDetails(int index) {
    final item = _items[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseDetailPage(exerciseName: item['text']),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: Icon(item['icon'], size: 30),
              title: Text(item['text']),
              onTap: () => _navigateToDetails(index),
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

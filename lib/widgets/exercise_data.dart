import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/dataset_model.dart';

final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');

class ExerciseDetailPage extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

// class ExerciseSet {
//   int reps;
//   double weight;
//   DateTime timestamp;

//   ExerciseSet({required this.reps, required this.weight})
//       : timestamp = DateTime.now();
// }

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  //final List<ExerciseSet> _history = [];

  void _addSet() {
    final TextEditingController repsController = TextEditingController();
    final TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              'Add a set',
              style: TextStyle(color: Colors.amber),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: repsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number of reps',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight [kg]',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
              ],
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
                  final reps = int.tryParse(repsController.text);
                  final weight = double.tryParse(weightController.text);
                  if (reps != null && weight != null) {
                    setState(() {
                      //_history.add(ExerciseSet(reps: reps, weight: weight));
                      widget.exercise.sets.add(
                        ExerciseSet(
                          reps: reps,
                          weight: weight,
                          timestamp: DateTime.now(),
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add', style: TextStyle(color: Colors.amber)),
              ),
            ],
          ),
    );
  }

  void _editSet(int index) {
    final set = widget.exercise.sets[index];
    final TextEditingController repsController = TextEditingController(
      text: set.reps.toString(),
    );
    final TextEditingController weightController = TextEditingController(
      text: set.weight.toString(),
    );

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              'Edit set',
              style: TextStyle(color: Colors.amber),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: repsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number of reps',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight [kg]',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                ),
              ],
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
                  final reps = int.tryParse(repsController.text);
                  final weight = double.tryParse(weightController.text);
                  if (reps != null && weight != null) {
                    setState(() {
                      widget.exercise.sets[index] = ExerciseSet(
                        reps: reps,
                        weight: weight,
                        timestamp: DateTime.now(),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                 child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
    );
  }

  void _confirmDeleteSet(int index) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirm deletion'),
            content: const Text('Are you sure you want to delete this set?'),
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
                    widget.exercise.sets.removeAt(index);
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

  String formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise.name)),
      body:
          widget.exercise.sets.isEmpty
              ? const Center(child: Text('Brak zapisanych serii'))
              : ListView.builder(
                itemCount: widget.exercise.sets.length,
                itemBuilder: (_, index) {
                  final set = widget.exercise.sets[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text('${set.reps} × ${set.weight} kg'),
                      subtitle: Text(formatDate(set.timestamp)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editSet(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDeleteSet(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: _addSet,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 32.0,
        ),
      ),
    );
  }
}

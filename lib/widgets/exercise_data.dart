import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');

class ExerciseDetailPage extends StatefulWidget {
  final String exerciseName;

  const ExerciseDetailPage({super.key, required this.exerciseName});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class ExerciseSet {
  int reps;
  double weight;
  DateTime timestamp;

  ExerciseSet({required this.reps, required this.weight})
      : timestamp = DateTime.now();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  final List<ExerciseSet> _history = [];

  void _addSet() {
    final TextEditingController repsController = TextEditingController();
    final TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Dodaj serię'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Powtórzenia'),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ciężar (kg)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          ElevatedButton(
            onPressed: () {
              final reps = int.tryParse(repsController.text);
              final weight = double.tryParse(weightController.text);
              if (reps != null && weight != null) {
                setState(() {
                  _history.add(ExerciseSet(reps: reps, weight: weight));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Dodaj'),
          ),
        ],
      ),
    );
  }

  void _editSet(int index) {
    final set = _history[index];
    final TextEditingController repsController = TextEditingController(text: set.reps.toString());
    final TextEditingController weightController = TextEditingController(text: set.weight.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edytuj serię'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Powtórzenia'),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ciężar (kg)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          ElevatedButton(
            onPressed: () {
              final reps = int.tryParse(repsController.text);
              final weight = double.tryParse(weightController.text);
              if (reps != null && weight != null) {
                setState(() {
                  _history[index] = ExerciseSet(reps: reps, weight: weight);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Zapisz'),
          ),
        ],
      ),
    );
  }

   void _confirmDeleteSet(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Potwierdź usunięcie'),
        content: const Text('Czy na pewno chcesz usunąć tę serię?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => _history.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Usuń'),
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
      appBar: AppBar(title: Text(widget.exerciseName)),
      body: _history.isEmpty
          ? const Center(child: Text('Brak zapisanych serii'))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (_, index) {
                final set = _history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        onPressed: _addSet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

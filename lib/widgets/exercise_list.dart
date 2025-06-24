import 'package:flutter/material.dart';
import '../data/exercise_data.dart';

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
  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.map, 'text': 'Map'},
    {'icon': Icons.photo_album, 'text': 'Album'},
    {'icon': Icons.phone, 'text': 'Phone'},
  ];

  final TextEditingController _textController = TextEditingController();

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          iconColor: Colors.amber,
          title: const Text('Add a new exercise'),
          content: TextField(
            controller: _textController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '[Text placeholder]',
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
              onPressed: () {
                Navigator.of(context).pop(); // zamknij dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.amber),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newItem = _textController.text.trim();
                if (newItem.isNotEmpty) {
                  setState(() {
                    _items.add({
                      //'icon': Icons.star, // domyślna ikona
                      'text': newItem,
                    });
                  });
                  _textController.clear(); // wyczyść pole
                  Navigator.of(context).pop(); // zamknij dialog
                }
              },
              child: const Text('Add', style: TextStyle(color: Colors.amber)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose(); // ważne, żeby nie było wycieku pamięci
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //appBar: AppBar(title: const Text('Dynamiczna lista')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            //margin zmienia odleglosc miedzy prostokatami
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              //To zmiena szerokosc prostokatow
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(item['icon'], size: 30),
                  const SizedBox(width: 16),
                  Text(item['text'], style: const TextStyle(fontSize: 16)),
                ],
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

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExerciceList(),
    );
  }
}

class ExerciceList extends StatefulWidget {
  const ExerciceList({super.key});

  @override
  State<ExerciceList> createState() => _ExerciceListState();
}

class _ExerciceListState extends State<ExerciceList> {
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
          title: const Text('Dodaj nowy element'),
          content: TextField(
            controller: _textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Nazwa elementu'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // zamknij dialog
              },
              child: const Text('Anuluj'),
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
              child: const Text('Dodaj'),
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
            Text(
              item['text'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
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

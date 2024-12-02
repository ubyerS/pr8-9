import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/game.dart';

class AddGameScreen extends StatefulWidget {
  final Function(Game) onAdd;

  const AddGameScreen({super.key, required this.onAdd});

  @override
  _AddGameScreenState createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  String? imageFilePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFilePath = pickedFile.path;
      });
    }
  }

  void _addGame() {
  final name = nameController.text;
  final price = double.tryParse(priceController.text) ?? 0.0;
  final description = descriptionController.text;

  if (name.isNotEmpty && description.isNotEmpty) {
    final newGame = Game(
      name: name,
      description: description,
      price: price,
      imageFilePath: imageFilePath,
    );
    widget.onAdd(newGame);
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Пожалуйста, заполните все поля!')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить игру')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Название')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Цена')),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Описание')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _pickImage, child: const Text('Выбрать изображение')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _addGame, child: const Text('Добавить')),
          ],
        ),
      ),
    );
  }
}

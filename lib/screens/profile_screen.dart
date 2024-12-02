import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController(text: 'Хидиров Карим');
  final groupController = TextEditingController(text: 'ЭФБО-03-22');
  final phoneController = TextEditingController(text: '+7 123 456 7890');
  final emailController = TextEditingController(text: 'khidirov@karim.com');

  void _saveProfile() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать профиль')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'ФИО')),
            TextField(controller: groupController, decoration: const InputDecoration(labelText: 'Группа')),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Телефон')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveProfile, child: const Text('Сохранить')),
          ],
        ),
      ),
    );
  }
}

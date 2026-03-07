import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya'), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Arvian CB', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('NIM: 224101000xx', style: TextStyle(color: Colors.grey)),
          const Divider(height: 40, indent: 20, endIndent: 20),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Jurusan'),
            subtitle: const Text('D4 Teknologi Informasi'),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: const Text('arvian@student.unair.ac.id'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pop(context), 
              child: const Text('Kembali'),
            ),
          ),
        ],
      ),
    );
  }
}
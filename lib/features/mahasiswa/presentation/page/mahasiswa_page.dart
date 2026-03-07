import 'package:flutter/material.dart';

class MahasiswaPage extends StatelessWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk kreativitas UI
    final List<Map<String, String>> listMahasiswa = [
      {'nama': 'Arvian CB', 'nim': '2241010001', 'prodi': 'D4 TI', 'status': 'Semester 4'},
      {'nama': 'Ahmad Fauzi', 'nim': '2241010005', 'prodi': 'D4 TI', 'status': 'Semester 4'},
      {'nama': 'Siti Aminah', 'nim': '2241010012', 'prodi': 'D4 TI', 'status': 'Semester 6'},
      {'nama': 'Budi Santoso', 'nim': '2241010020', 'prodi': 'D4 TI', 'status': 'Semester 2'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Bar Pemanis
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Nama atau NIM...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listMahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = listMahasiswa[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Text(mhs['nama']![0], style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(mhs['nama']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${mhs['nim']} • ${mhs['prodi']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(mhs['status']!, style: const TextStyle(fontSize: 10, color: Colors.blue)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
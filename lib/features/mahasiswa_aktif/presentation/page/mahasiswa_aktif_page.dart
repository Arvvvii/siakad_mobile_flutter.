import 'package:flutter/material.dart';

class MahasiswaAktifPage extends StatelessWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Aktif'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Highlight
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Aktif Semester Ini', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text('1,240 Mahasiswa', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('↑ 12% dari semester lalu', style: TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Rincian Per Jurusan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // List rincian sederhana
            _buildJurusanItem(context, 'Angkatan 2022', '450 Mhs', 0.8),
            _buildJurusanItem(context, 'Angkatan 2023', '320 Mhs', 0.6),
            _buildJurusanItem(context, 'Angkatan 2024', '280 Mhs', 0.5),
            _buildJurusanItem(context, 'Angkatan 2025', '190 Mhs', 0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildJurusanItem(BuildContext context, String title, String count, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(count, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: Theme.of(context).primaryColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
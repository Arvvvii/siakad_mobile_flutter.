import 'dart:io';

void main() {
  // === INPUT DATA MAHASISWA (Single) ===
  print('=== INPUT DATA MAHASISWA ===');
  Map<String, dynamic> mahasiswa = {};

  stdout.write('Masukkan NIM: ');
  mahasiswa['nim'] = stdin.readLineSync()!;

  stdout.write('Masukkan Nama: ');
  mahasiswa['nama'] = stdin.readLineSync()!;

  stdout.write('Masukkan Jurusan: ');
  mahasiswa['jurusan'] = stdin.readLineSync()!;

  stdout.write('Masukkan IPK: ');
  mahasiswa['ipk'] = stdin.readLineSync()!;

  print('\nData Mahasiswa: $mahasiswa');

  print('\n' + '=' * 30 + '\n');

  // === INPUT MULTIPLE MAHASISWA ===
  print('=== INPUT MULTIPLE MAHASISWA ===');
  List<Map<String, dynamic>> daftarMahasiswa = [];

  stdout.write('Masukkan jumlah mahasiswa: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < jumlah; i++) {
    print('\n--- Mahasiswa ke-${i + 1} ---');
    Map<String, dynamic> mhsData = {};

    stdout.write('Masukkan NIM: ');
    mhsData['nim'] = stdin.readLineSync()!;

    stdout.write('Masukkan Nama: ');
    mhsData['nama'] = stdin.readLineSync()!;

    stdout.write('Masukkan Jurusan: ');
    mhsData['jurusan'] = stdin.readLineSync()!;

    stdout.write('Masukkan IPK: ');
    mhsData['ipk'] = stdin.readLineSync()!;

    daftarMahasiswa.add(mhsData);
  }

  // Menampilkan hasil multiple mahasiswa
  print('\nDaftar Semua Mahasiswa:');
  for (var m in daftarMahasiswa) {
    print(m);
  }
}
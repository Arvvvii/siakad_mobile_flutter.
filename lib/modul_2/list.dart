import 'dart:io';

void main() {
  // Membuat list dengan model input data
  List<String> dataList = [];
  print('Data list kosong: $dataList');

  // Mengambil jumlah data dari pengguna
  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync();
    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid! Masukkan angka yang benar.');
    }
  }

  // Memasukkan data ke dalam list menggunakan for loop
  for (int i = 0; i < count; i++) {
    stdout.write('data ke-${i + 1}: ');
    String x = stdin.readLineSync()!;
    dataList.add(x);
  }

  // Menampilkan data list
  print('Data list:');
  print(dataList);

  // --- POIN M: Inputan untuk Tampil, Ubah, Hapus berdasarkan index ---

  // 1. Tampil berdasarkan index tertentu
  stdout.write('\nTampilkan data index ke: ');
  int idxTampil = int.parse(stdin.readLineSync()!);
  print('Data di index $idxTampil adalah: ${dataList[idxTampil]}');

  // 2. Ubah berdasarkan index tertentu
  stdout.write('Ubah data index ke: ');
  int idxUbah = int.parse(stdin.readLineSync()!);
  stdout.write('Masukkan data baru: ');
  String dataBaru = stdin.readLineSync()!;
  dataList[idxUbah] = dataBaru;

  // 3. Hapus berdasarkan index tertentu
  stdout.write('Hapus data index ke: ');
  int idxHapus = int.parse(stdin.readLineSync()!);
  dataList.removeAt(idxHapus);

  // 4. Tampilkan hasil akhir sesuai contoh di modul
  print('\n=== SEMUA DATA (HASIL AKHIR) ===');
  for (int i = 0; i < dataList.length; i++) {
    print('Index $i: ${dataList[i]}');
  }
}
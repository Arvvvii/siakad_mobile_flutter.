import 'dart:io';

void main() {
  // b. Membuat Set dengan data awal hero
  Set<String> heroes = {'Odette', 'Guinevere', 'Kagura'};

  // Menampilkan data dengan format nomor urut sesuai modul
  print('=== SEMUA DATA ===');
  int i = 1;
  for (var h in heroes) {
    print('${i++}. $h');
  }
  print('Total data: ${heroes.length}');

  // Fitur Tambah data baru
  stdout.write('Masukkan data baru: ');
  String? baru = stdin.readLineSync();
  if (baru != null && baru.isNotEmpty) {
    if (heroes.add(baru)) {
      print('Data "$baru" berhasil ditambahkan!');
    } else {
      print('Data "$baru" sudah ada di Set!');
    }
  }

  // Fitur Hapus data
  stdout.write('Masukkan data yang ingin dihapus: ');
  String? hapus = stdin.readLineSync();
  if (heroes.remove(hapus)) {
    print('Data "$hapus" berhasil dihapus!');
  } else {
    print('Data "$hapus" tidak ditemukan!');
  }

  // Fitur Cek data tertentu
  stdout.write('Masukkan data yang ingin dicek: ');
  String? cek = stdin.readLineSync();
  if (heroes.contains(cek)) {
    print('Data "$cek" ada di dalam Set!');
  } else {
    print('Data "$cek" tidak ada di Set!');
  }
}
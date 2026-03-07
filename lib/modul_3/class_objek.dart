import 'dart:io';

class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  void tampilkanData() {
    print("Nama: ${nama ?? 'Belum diisi'}");
    print("NIM: ${nim ?? 'Belum diisi'}");
    print("Jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

// c. Extends (Pewarisan)
class MahasiswaAktif extends Mahasiswa {
  int? semester;

  @override
  void tampilkanData() {
    print("Data Mahasiswa Aktif");
    super.tampilkanData();
    print("Semester: ${semester ?? 'Belum diisi'}");
  }
}

class MahasiswaAlumni extends Mahasiswa {
  int? tahunLulus;

  @override
  void tampilkanData() {
    print("Data Mahasiswa Alumni");
    super.tampilkanData();
    print("Tahun Lulus: ${tahunLulus ?? 'Belum diisi'}");
  }
}

// d. Mixin (Minimal 3 Mixin)
mixin Presensi {
  void catatKehadiran() => print("Status: Kehadiran telah dicatat.");
}

mixin Penilaian {
  void beriNilai() => print("Status: Proses penilaian selesai.");
}

mixin InformasiFakultas {
  void cekAkreditasi() => print("Fakultas: Terakreditasi Unggul.");
}

// Implementasi Mixin pada Class Dosen dan Fakultas
class Dosen extends Mahasiswa with Presensi, Penilaian {
  String? nip;

  void infoDosen() {
    print("NIP Dosen: $nip");
    catatKehadiran();
    beriNilai();
  }
}

class Fakultas extends Mahasiswa with InformasiFakultas {
  String? namaFakultas;

  void tampilkanFakultas() {
    print("Nama Unit: $namaFakultas");
    cekAkreditasi();
  }
}

void main() {
  // Menjalankan poin C (Extends)
  print("TESTING EXTENDS");
  var mhsAktif = MahasiswaAktif();
  mhsAktif.nama = "Arviansyah";
  mhsAktif.nim = 2024001;
  mhsAktif.jurusan = " D4 Teknik Informatika";
  mhsAktif.semester = 3;
  mhsAktif.tampilkanData();

  print("\nTESTING ALUMNI");
var alumni = MahasiswaAlumni();
alumni.nama = "Jisoo";
alumni.nim = 434241031;
alumni.jurusan = "D4 Teknik Informatika";
alumni.tahunLulus = 2023;
alumni.tampilkanData();

  print("\n");

  // Menjalankan poin D (Mixin)
  print("TESTING MIXIN");
  var dosenTI = Dosen();
  dosenTI.nip = "198801012024";
  dosenTI.infoDosen();
  
  print("---");
  
  var fakultasVokasi = Fakultas();
  fakultasVokasi.namaFakultas = "Fakultas Vokasi";
  fakultasVokasi.tampilkanFakultas();
}
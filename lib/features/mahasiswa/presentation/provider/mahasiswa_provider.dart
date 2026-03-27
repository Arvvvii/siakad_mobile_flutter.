import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arviancb/core/services/local_storage_service.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Simpan pakai fungsi modul
  Future<void> saveMahasiswa(MahasiswaModel mhs) async {
    await _storage.addUserToSavedList(
      userId: mhs.id.toString(),
      username: mhs.name,
    );
  }

  // Hapus pakai fungsi modul
  Future<void> deleteMahasiswa(String id) async {
    await _storage.removeSavedUser(id);
  }

  Future<void> deleteAll() async {
    await _storage.clearSavedUsers();
  }

  Future<void> refresh() async => await loadMahasiswaList();
}

final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return MahasiswaNotifier(repository, storage);
});
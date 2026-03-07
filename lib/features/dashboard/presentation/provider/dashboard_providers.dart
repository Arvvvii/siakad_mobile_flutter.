import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dashboard_model.dart';
import '../../data/repositories/dashboard_repository.dart';

/// 1. PROVIDER UNTUK REPOSITORY
/// Digunakan untuk menyediakan instance DashboardRepository ke provider lain
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

/// 2. STATENOTIFIER UNTUK MENGELOLA STATE DASHBOARD
/// Menggunakan AsyncValue untuk menangani state Loading, Error, dan Data secara otomatis
class DashboardNotifier extends StateNotifier<AsyncValue<DashboardData>> {
  final DashboardRepository _repository;

  DashboardNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDashboard();
  }

  /// MENDAPATKAN DATA DASHBOARD
  /// Fungsi utama untuk mengambil data dari repository saat pertama kali diinisialisasi
  Future<void> loadDashboard() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDashboardData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// REFRESH DATA DASHBOARD
  /// Fungsi ini dipanggil saat user melakukan pull-to-refresh atau klik tombol refresh
  Future<void> refresh() async {
    try {
      // Mengambil data terbaru tanpa mengubah state menjadi loading secara total
      // agar UI tidak berkedip (flicker)
      final data = await _repository.getDashboardData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// UPDATE STATISTIC DATA (Jika diperlukan update manual pada UI)
  void updateStats(List<DashboardStats> newStats) {
    if (state is AsyncData<DashboardData>) {
      final currentData = state.asData!.value;
      state = AsyncValue.data(
        DashboardData(
          userName: currentData.userName,
          lastUpdate: currentData.lastUpdate,
          stats: newStats,
        ),
      );
    }
  }
}

/// 3. PROVIDER UTAMA UNTUK DASHBOARD NOTIFIER
/// Menghubungkan Repository dengan Notifier agar bisa di-watch oleh UI
final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, AsyncValue<DashboardData>>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository);
});

/// 4. PROVIDER UNTUK INDEX STATISTIK YANG DIPILIH
/// Default adalah -1 (tidak ada yang dipilih)
/// Digunakan untuk efek visual 'isSelected' pada DashboardStatCard
final selectedStatIndexProvider = StateProvider<int>((ref) => -1);

/// 5. PROVIDER UNTUK TOTAL MAHASISWA (MENGAMBIL DARI DATA DASHBOARD)
/// Contoh selector provider untuk mengambil data spesifik
final totalMahasiswaProvider = Provider<String>((ref) {
  final dashboardState = ref.watch(dashboardNotifierProvider);
  return dashboardState.maybeWhen(
    data: (data) => data.stats.firstWhere((s) => s.title == 'Total Mahasiswa').value,
    orElse: () => '0',
  );
});
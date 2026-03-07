import '../models/dashboard_model.dart';

class DashboardRepository {
  /// Mendapatkan data dashboard
  Future<DashboardData> getDashboardData() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy dashboard (Disesuaikan dengan Model terbaru)
    return DashboardData(
      userName: 'Admin D4TI',
      lastUpdate: '6 Mar 2026, 2:02', // Sesuai dengan foto modul hal 28
      stats: [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: '1,200',
          subtitle: '',
        ),
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: '550',
          subtitle: '',
        ),
        DashboardStats(
          title: 'Dosen',
          value: '650',
          subtitle: '',
        ),
        DashboardStats(
          title: 'Profile',
          value: 'Admin',
          subtitle: '',
        ),
      ],
    );
  }

  /// Refresh dashboard data
  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }

  /// Get specific stat by title
  Future<DashboardStats?> getStatByTitle(String title) async {
    try {
      final data = await getDashboardData();
      return data.stats.firstWhere((stat) => stat.title == title);
    } catch (e) {
      return null;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../provider/dashboard_providers.dart';
import '../widgets/dashboard_widget.dart';
import '../../../dosen/presentation/page/dosen_page.dart';
import '../../../mahasiswa/presentation/page/mahasiswa_page.dart';
import '../../../mahasiswa_aktif/presentation/page/mahasiswa_aktif_page.dart';
import '../../../profile/presentation/page/profile_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  /// ICON DATA BERDASARKAN TITLE
  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Total Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_outline_rounded;
      case 'Mahasiswa Lulus':
        return Icons.workspace_premium_rounded;
      case 'Dosen':
        return Icons.people_outline_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      body: dashboardState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () => ref.read(dashboardNotifierProvider.notifier).refresh(),
        ),
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(dashboardNotifierProvider.notifier).refresh();
            },
            child: CustomScrollView(
              slivers: [
                /// HEADER DASHBOARD
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withBlue(220),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Selamat Datang,',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        dashboardData.userName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // TOMBOL PROFILE DI HEADER (BIAR BISA DIKLIK)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.person_outline,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, _createRoute(const ProfilePage()));
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Update: ${_formatDate(dashboardData.lastUpdate)}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// STATISTIC TITLE
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Statistik',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                ref.read(dashboardNotifierProvider.notifier).refresh();
                              },
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text('Refresh'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        /// GRID STAT (LOGIKA NAVIGASI DI SINI)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            final stat = dashboardData.stats[index];
                            return StatCard(
                              stats: stat,
                              icon: _getIconForStat(stat.title),
                              gradientColors: AppConstants.dashboardGradients[
                                  index % AppConstants.dashboardGradients.length],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                ref.read(selectedStatIndexProvider.notifier).state = index;

                                Widget? targetPage;
                                switch (stat.title) {
                                  case 'Total Mahasiswa':
                                    targetPage = const MahasiswaPage();
                                    break;
                                  case 'Mahasiswa Aktif':
                                    targetPage = const MahasiswaAktifPage();
                                    break;
                                  case 'Dosen':
                                    targetPage = const DosenPage();
                                    break;
                                  case 'Mahasiswa Lulus':
                                    // Bisa diarahkan ke Profile atau halaman Lulus khusus
                                    targetPage = const ProfilePage();
                                    break;
                                }

                                if (targetPage != null) {
                                  Navigator.push(context, _createRoute(targetPage));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ANIMATION ROUTE (SLIDE KANAN KE KIRI)
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// FORMAT DATE
  String _formatDate(String date) {
    try {
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
      ];
      final dateTime = DateTime.parse(date);
      return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}, '
          '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return date;
    }
  }
}
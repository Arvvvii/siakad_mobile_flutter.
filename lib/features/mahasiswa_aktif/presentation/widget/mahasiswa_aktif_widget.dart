import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/mahasiswa_aktif_model.dart';

class ModernMahasiswaAktifCard extends StatelessWidget {

  final MahasiswaAktifModel mahasiswaAktif;
  final List<Color>? gradientColors;

  const ModernMahasiswaAktifCard({
    super.key,
    required this.mahasiswaAktif,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    final colors =
        gradientColors ?? [primaryColor, primaryColor.withOpacity(0.8)];

    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              mahasiswaAktif.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              mahasiswaAktif.body,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class MahasiswaAktifListView extends StatelessWidget {

  final List<MahasiswaAktifModel> mahasiswaAktifList;
  final VoidCallback onRefresh;

  const MahasiswaAktifListView({
    super.key,
    required this.mahasiswaAktifList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),

      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: mahasiswaAktifList.length,

        itemBuilder: (context, index) {

          final mahasiswaAktif = mahasiswaAktifList[index];

          return ModernMahasiswaAktifCard(
            mahasiswaAktif: mahasiswaAktif,
            gradientColors: AppConstants.dashboardGradients[
                index % AppConstants.dashboardGradients.length],
          );
        },
      ),
    );
  }
}
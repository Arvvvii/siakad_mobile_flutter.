import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/dosen_model.dart';

class ModernDosenCard extends StatefulWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernDosenCard({
    Key? key,
    required this.dosen,
    this.onTap,
    this.gradientColors,
  }) : super(key: key);

  @override
  State<ModernDosenCard> createState() => _ModernDosenCardState();
}

class _ModernDosenCardState extends State<ModernDosenCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final colors = widget.gradientColors ?? [primaryColor, primaryColor.withOpacity(0.8)];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colors[0].withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned(
                  right: -15,
                  top: -15,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: colors[0].withOpacity(0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Avatar Bulat
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: colors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            widget.dosen.nama.isNotEmpty 
                                ? widget.dosen.nama.substring(0, 1).toUpperCase() 
                                : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Info Dosen
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.dosen.nama,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.dosen.jurusan,
                              style: TextStyle(
                                fontSize: 12,
                                color: colors[0],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildInfoDetail(Icons.badge_outlined, 'NIP: ${widget.dosen.nip}'),
                            _buildInfoDetail(Icons.mail_outline_rounded, widget.dosen.email),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// ============================================================
/// 2. DOSEN LIST VIEW (FIXED)
/// ============================================================
class DosenListView extends StatelessWidget {
  final List<DosenModel> dosenList;
  final VoidCallback onRefresh;
  final bool useModernCard;

  const DosenListView({
    Key? key,
    required this.dosenList,
    required this.onRefresh,
    this.useModernCard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dosenList.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: ListView(
          children: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text('Data dosen tidak ditemukan'),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          if (useModernCard) {
            return ModernDosenCard(
              dosen: dosen,
              onTap: () {
                debugPrint("Detail ${dosen.nama}");
              },
            );
          }
          return ListTile(title: Text(dosen.nama));
        },
      ),
    );
  }
}
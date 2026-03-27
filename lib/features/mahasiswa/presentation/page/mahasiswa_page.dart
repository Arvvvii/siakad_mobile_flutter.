import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arviancb/features/mahasiswa/presentation/provider/mahasiswa_provider.dart';
import 'package:arviancb/features/mahasiswa/presentation/widget/mahasiswa_widget.dart';
import 'package:arviancb/core/widgets/common_widgets.dart';
import 'package:arviancb/features/dosen/presentation/provider/dosen_provider.dart'; 

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
    final savedUsersAsync = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          savedUsersAsync.when(
            data: (savedUsers) => savedUsers.isEmpty 
              ? const SizedBox.shrink() 
              : Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Data Tersimpan", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextButton(
                            onPressed: () async {
                              await ref.read(mahasiswaNotifierProvider.notifier).deleteAll();
                              ref.invalidate(savedUsersProvider);
                            },
                            child: const Text("Hapus Semua", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                      const Divider(),
                      ...savedUsers.map((user) => ListTile(
                        dense: true,
                        // SESUAI MODUL: pakai 'user_id' bukan 'id'
                        leading: CircleAvatar(radius: 12, child: Text(user['user_id'] ?? '?', style: const TextStyle(fontSize: 10))),
                        title: Text(user['username'] ?? '', style: const TextStyle(fontSize: 13)),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red, size: 16),
                          onPressed: () async {
                            await ref.read(mahasiswaNotifierProvider.notifier).deleteMahasiswa(user['user_id']!);
                            ref.invalidate(savedUsersProvider);
                          },
                        ),
                      )),
                    ],
                  ),
                ),
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          Expanded(
            child: mahasiswaState.when(
              loading: () => const LoadingWidget(),
              error: (e, s) => CustomErrorWidget(message: e.toString(), onRetry: () => ref.refresh(mahasiswaNotifierProvider)),
              data: (list) => MahasiswaListView(
                mahasiswaList: list,
                onRefresh: () => ref.invalidate(mahasiswaNotifierProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
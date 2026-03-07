import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/dosen_provider.dart';
import '../widget/dosen_widget.dart';
import '../../../../core/widgets/common_widgets.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),

      body: dosenState.when(
        /// STATE: LOADING
        loading: () => const LoadingWidget(),

        /// STATE: ERROR
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data dosen: ${error.toString()}',
          onRetry: () {
            ref.read(dosenNotifierProvider.notifier).refresh();
          },
        ),

        /// STATE: DATA
        data: (dosenList) {
          return DosenListView(
            dosenList: dosenList,
            onRefresh: () {
              ref.invalidate(dosenNotifierProvider);
            },
            useModernCard: true, // set false untuk card sederhana
          );
        },
      ),
    );
  }
}
import 'package:assembly/features/assemblies/presentation/controllers/single_assembly_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssemblyDetailPage extends ConsumerWidget {
  final String assemblyId;
  const AssemblyDetailPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblyAsync = ref.watch(
      singleAssemblyControllerProvider(assemblyId),
    );
    return Scaffold(
      appBar: AppBar(
        title: assemblyAsync.when(
          data: (data) => Text(data?.name ?? ''),
          error: (error, stackTrace) => SizedBox.shrink(),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

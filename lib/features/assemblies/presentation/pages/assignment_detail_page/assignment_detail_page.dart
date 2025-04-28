import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignments_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignmentDetailPage extends ConsumerWidget {
  final String assemblyId;
  final String assignmentId;
  const AssignmentDetailPage({
    super.key,
    required this.assemblyId,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentGroupsAsync = ref.watch(
      assignmentsListControllerProvider(assemblyId, assignmentId),
    );
    return Scaffold(
      body: assignmentGroupsAsync.when(
        data: (assignmentGroups) {
          return ListView.builder(
            itemCount: assignmentGroups.length,
            itemBuilder: (context, index) {
              final group = assignmentGroups[index];
              return ListTile(
                title: Text(group.assignment),
                subtitle: Text('Created at: ${group.createdAt}'),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text(error as String)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

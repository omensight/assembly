import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignments_list_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
      //TODO set assignment name
      appBar: AppBar(title: Text('Assignment')),
      body: assignmentGroupsAsync.when(
        data: (assignmentGroups) {
          return assignmentGroups.isEmpty
              ? Center(
                child: AssignmentGroupsEmptyStateView(assemblyId: assemblyId),
              )
              : ListView.builder(
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

class AssignmentGroupsEmptyStateView extends ConsumerWidget {
  final String assemblyId;
  const AssignmentGroupsEmptyStateView({super.key, required this.assemblyId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAssemblyRole = ref.watch(
      currentAssemblyMemberRoleProvider(assemblyId),
    );
    return [AssemblyMemberRole.admin].contains(currentAssemblyRole)
        ? StandardEmptyView(
          title: LocaleKeys.titleAssignmentNotInitialized.tr(),
          imagePath: 'assets/empty_views/im_ev_no_events.png',
          message: LocaleKeys.youHaveToInitializeThisAssignment.tr(),
          actionButton: StandardButton(
            text: LocaleKeys.initialize.tr(),
            isBackgroundColored: true,
            onPressed: () {},
          ),
        )
        : StandardEmptyView(
          imagePath: 'assets/empty_views/im_ev_no_events.png',
          message: LocaleKeys.messageAssignmentNotInitialized.tr(),
        );
  }
}

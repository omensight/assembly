import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_settings_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignments_list_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/routes.dart';
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
    final assignmentAsync = ref.watch(
      assignmentControllerProvider(assemblyId, assignmentId),
    );

    final assignmentSettingsAsync = ref.watch(
      assignmentSettingsControllerProvider(assemblyId, assignmentId),
    );

    final assignmentGroupsAsync = ref.watch(
      assignmentsListControllerProvider(assemblyId, assignmentId),
    );

    final assemblyMemberRole = ref.watch(
      currentAssemblyMemberRoleProvider(assemblyId),
    );

    return Scaffold(
      appBar: AppBar(
        title: assignmentAsync.when(
          data: (assignment) => Text(assignment.name),
          error: (_, _) => Text(LocaleKeys.assignment.tr()),
          loading: () => Text(LocaleKeys.assignment.tr()),
        ),
      ),
      body: assignmentSettingsAsync.when(
        data: (settings) {
          if (settings == null) {
            return NoAssignmentSettingsEmptyStateView(
              assemblyMemberRole: assemblyMemberRole,
              assemblyId: assemblyId,
              assignmentId: assignmentId,
            );
          }
          return assignmentGroupsAsync.when(
            data: (assignmentGroups) {
              return assignmentGroups.isEmpty
                  ? Center(
                    child: AssignmentGroupsEmptyStateView(
                      assemblyId: assemblyId,
                      assignmentId: assignmentId,
                    ),
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
          );
        },
        error:
            (error, stackTrace) => Center(
              child: Text(LocaleKeys.failureLoadingAssignmentSettings.tr()),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class AssignmentGroupsEmptyStateView extends ConsumerWidget {
  final String assemblyId;
  final String assignmentId;

  const AssignmentGroupsEmptyStateView({
    super.key,
    required this.assemblyId,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAssemblyRole = ref.watch(
      currentAssemblyMemberRoleProvider(assemblyId),
    );
    return [AssemblyMemberRole.admin].contains(currentAssemblyRole)
        ? StandardEmptyView(
          title: LocaleKeys.titleAssignmentNotConfigured.tr(),
          imagePath: 'assets/empty_views/im_ev_no_events.png',
          message: LocaleKeys.youHaveToInitializeThisAssignment.tr(),
          actionButton: StandardButton(
            text: LocaleKeys.initialize.tr(),
            isBackgroundColored: true,
            onPressed: () {
              CreateAssignmentSettingsRoute(
                assemblyId: assemblyId,
                assignmentId: assignmentId,
              ).go(context);
            },
          ),
        )
        : StandardEmptyView(
          imagePath: 'assets/empty_views/im_ev_no_events.png',
          message: LocaleKeys.messageAssignmentNotInitialized.tr(),
        );
  }
}

class NoAssignmentSettingsEmptyStateView extends StatelessWidget {
  const NoAssignmentSettingsEmptyStateView({
    super.key,
    required this.assemblyMemberRole,
    required this.assemblyId,
    required this.assignmentId,
  });

  final AssemblyMemberRole assemblyMemberRole;
  final String assemblyId;
  final String assignmentId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StandardEmptyView(
        message: switch (assemblyMemberRole) {
          AssemblyMemberRole.admin =>
            LocaleKeys.thisAssignmentHasNotBeenConfiguredYetForAdmin.tr(),
          AssemblyMemberRole.member =>
            LocaleKeys.thisAssignmentHasNotBeenConfiguredYetForMember.tr(),
        },
        title: LocaleKeys.titleAssignmentNotConfigured.tr(),
        actionButton: switch (assemblyMemberRole) {
          AssemblyMemberRole.admin => StandardButton(
            text: LocaleKeys.configureAssignment.tr(),
            isBackgroundColored: true,
            onPressed: () {
              CreateAssignmentSettingsRoute(
                assemblyId: assemblyId,
                assignmentId: assignmentId,
              ).push(context);
            },
          ),
          AssemblyMemberRole.member => null,
        },
        imagePath: 'assets/empty_views/im_ev_no_assembly_settings.png',
      ),
    );
  }
}

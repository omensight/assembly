import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/routes.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          title: LocaleKeys.noGroupsFoundTitle.tr(),
          imagePath: 'assets/empty_views/im_ev_no_events.png',
          message: switch (currentAssemblyRole) {
            AssemblyMemberRole.admin =>
              LocaleKeys.noGroupsFoundDescriptionForAdmin.tr(),
            AssemblyMemberRole.member =>
              LocaleKeys.noGroupsFoundDescriptionForMember.tr(),
          },
          actionButton:
              currentAssemblyRole == AssemblyMemberRole.admin
                  ? StandardButton(
                    text: LocaleKeys.createGroups.tr(),
                    isBackgroundColored: true,
                    onPressed: () {
                      CreateAssignmentSettingsRoute(
                        assemblyId: assemblyId,
                        assignmentId: assignmentId,
                      ).go(context);
                    },
                  )
                  : null,
        )
        : StandardEmptyView(
          imagePath: 'assets/empty_views/im_ev_no_events.png',
          message: LocaleKeys.messageAssignmentNotInitialized.tr(),
        );
  }
}

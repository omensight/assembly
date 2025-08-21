import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/routes.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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

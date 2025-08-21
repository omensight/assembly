import 'package:assembly/core/constants.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_detail_provider.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/routes.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
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
    final assignmentDetailDtoAsync = ref.watch(
      assignmentDetailDTOProvider(assemblyId, assignmentId),
    );

    return Scaffold(
      appBar: AppBar(
        title: assignmentDetailDtoAsync.when(
          data:
              (assignmentDetailDto) =>
                  Text(assignmentDetailDto.assignment.name),
          error: (_, _) => Text(LocaleKeys.assignment.tr()),
          loading: () => Text(LocaleKeys.assignment.tr()),
        ),
      ),
      body: assignmentDetailDtoAsync.when(
        data: (assignmentDetailDto) {
          if (assignmentDetailDto.assignmentSettings == null) {
            return NoAssignmentSettingsEmptyStateView(
              assemblyMemberRole: assignmentDetailDto.assemblyMemberRole,
              assemblyId: assemblyId,
              assignmentId: assignmentId,
            );
          }
          final assignmentGroups = assignmentDetailDto.assignmentGroups;
          return Padding(
            padding: standardHorizontalPadding,
            child:
                assignmentGroups.isEmpty
                    ? Center(
                      child: AssignmentGroupsEmptyStateView(
                        assemblyId: assemblyId,
                        assignmentId: assignmentId,
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignmentDetailDto.assignmentSettings?.groupSize == 1
                              ? LocaleKeys.assignees.tr()
                              : LocaleKeys.assigneeGroups.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const StandardSpace.vertical(),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder:
                                (context, index) =>
                                    const StandardSpace.vertical(),
                            itemCount: assignmentGroups.length,
                            itemBuilder: (context, index) {
                              final group = assignmentGroups[index];
                              final isMarkStatusVisible =
                                  assignmentDetailDto
                                      .assignment
                                      .activeGroupId ==
                                  group.id;

                              return StandardContainer(
                                borderRadius: kStandardMinimalRadius,
                                backgroundColor:
                                    assignmentDetailDto
                                                .assignment
                                                .activeGroupId ==
                                            group.id
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer
                                        : Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerLow,
                                forceBorderDrawing: true,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (assignmentDetailDto
                                            .assignment
                                            .activeGroupId ==
                                        group.id)
                                      Text(
                                        assignmentDetailDto
                                                    .assignmentSettings
                                                    ?.groupSize ==
                                                1
                                            ? LocaleKeys.currentlyAssignedMember
                                                .tr()
                                            : LocaleKeys.currentlyAssignedGroup
                                                .tr(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                    if (isMarkStatusVisible)
                                      MarkAssignmentGroupAsCompletedWidget(
                                        assignmentGroup: group,
                                        assemblyId: assemblyId,
                                      ),
                                    ListView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children:
                                          group.assignees
                                              .mapWithIndex(
                                                (e, i) => Text(
                                                  e
                                                      .assemblyMember
                                                      .user
                                                      .fullName,
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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

class MarkAssignmentGroupAsCompletedWidget extends ConsumerWidget {
  const MarkAssignmentGroupAsCompletedWidget({
    super.key,
    required this.assignmentGroup,
    required this.assemblyId,
  });

  final String assemblyId;
  final AssignmentGroup assignmentGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completion = assignmentGroup.completion;
    final isMarkedAsCompleted = completion != null;
    final isConfirmed = completion?.isConfirmed ?? false;

    if (isMarkedAsCompleted && isConfirmed) {
      return Text(
        LocaleKeys.assingnmentCompleted.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    if (isMarkedAsCompleted && !isConfirmed) {
      return Text(
        LocaleKeys.awaitingConfirmation.tr(),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.deepOrange),
      );
    }

    final markAsCompletionStatus = ref.watch(
      markAssignmentGroupCompletedControllerProvider(
        assemblyId: assemblyId,
        assignmentGroupId: assignmentGroup.id,
        assignmentId: assignmentGroup.assignmentId,
      ),
    );

    return StandardButton(
      buttonState:
          markAsCompletionStatus.isLoading
              ? StandardButtonState.loading
              : StandardButtonState.standBy,
      text: LocaleKeys.markAsCompleted.tr(),
      onPressed: () {
        ref
            .read(
              markAssignmentGroupCompletedControllerProvider(
                assemblyId: assemblyId,
                assignmentGroupId: assignmentGroup.id,
                assignmentId: assignmentGroup.assignmentId,
              ).notifier,
            )
            .markGroupAsCompleted();
      },
      isBackgroundColored: true,
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

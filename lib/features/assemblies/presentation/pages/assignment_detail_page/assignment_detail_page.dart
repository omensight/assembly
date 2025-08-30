import 'package:assembly/core/constants.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_detail_provider.dart';
import 'package:assembly/features/assemblies/presentation/pages/assignment_detail_page/widgets/assignment_detail_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/assignment_detail_page/widgets/assignment_groups_empty_state_view.dart';
import 'package:assembly/features/assemblies/presentation/pages/assignment_detail_page/widgets/assignment_group_status_widget.dart';
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
          var assignmentSettings = assignmentDetailDto.assignmentSettings;
          if (assignmentSettings == null) {
            return NoAssignmentSettingsEmptyStateView(
              assemblyMemberRole: assignmentDetailDto.assemblyMemberRole,
              assemblyId: assemblyId,
              assignmentId: assignmentId,
            );
          }
          final assignmentGroups = assignmentDetailDto.assignmentGroups;
          final startDate = assignmentSettings.startDateAndTime;
          final hasTheAssignmentStarted = DateTime.now().isAfter(startDate);
          final activeAssignmentCycleStartDate =
              assignmentDetailDto
                  .assignment
                  .activeAssignmentCycle
                  ?.startDateAndTime;

          return Padding(
            padding: standardHorizontalPadding,
            child: Column(
              children: [
                StandardContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (activeAssignmentCycleStartDate != null)
                        Row(
                          spacing: kStandardSpacing,

                          children: [
                            Tooltip(
                              message: LocaleKeys.startDateAndTime.tr(),
                              child: const Icon(Icons.calendar_month),
                            ),
                            Text(
                              kStandardDateAndTimeFormat.format(
                                activeAssignmentCycleStartDate.toLocal(),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        spacing: kStandardSpacing,
                        children: [
                          assignmentSettings.groupSize == 1
                              ? const Icon(Icons.person)
                              : const Icon(Icons.group),
                          Text(assignmentGroups.length.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
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
                                assignmentDetailDto
                                            .assignmentSettings
                                            ?.groupSize ==
                                        1
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
                                    final isGroupActive =
                                        assignmentDetailDto
                                            .assignment
                                            .activeAssignmentCycle
                                            ?.activeGroupId ==
                                        group.id;
                                    return StandardContainer(
                                      forceBorderDrawing: isGroupActive,
                                      borderColor:
                                          isGroupActive
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                              : null,
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (assignmentDetailDto
                                                      .assignment
                                                      .activeAssignmentCycle
                                                      ?.activeGroupId ==
                                                  group.id)
                                                Text(
                                                  assignmentDetailDto
                                                              .assignmentSettings
                                                              ?.groupSize ==
                                                          1
                                                      ? LocaleKeys
                                                          .currentlyAssignedMember
                                                          .tr()
                                                      : LocaleKeys
                                                          .currentlyAssignedGroup
                                                          .tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                      ),
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
                                          Column(
                                            children: [
                                              if (hasTheAssignmentStarted)
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: AssignmentGroupStatusWidget(
                                                    assignmentGroup: group,
                                                    assemblyId: assemblyId,
                                                    cycleId:
                                                        assignmentDetailDto
                                                            .assignment
                                                            .activeAssignmentCycle!
                                                            .id,
                                                    currentAssemblyMember:
                                                        assignmentDetailDto
                                                            .currentAssemblyMember,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
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

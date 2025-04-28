import 'dart:async';

import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/usecases/assignments/get_assignments_groups_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignments_list_controller.g.dart';

@riverpod
class AssignmentsListController extends _$AssignmentsListController {
  @override
  FutureOr<List<AssignmentGroup>> build(
    String assemblyId,
    String assignmentId,
  ) async {
    return (await ref
            .watch(getAssignmentsGroupsUsecaseProvider)
            .build(
              GetAssignmentsGroupsParams(
                assignmentId: assignmentId,
                assemblyId: assemblyId,
              ),
            )
            .run())
        .fold(
          (l) => switch (l) {
            GetAssignmentGroupsNetworkFailure() => Future.error(
              LocaleKeys.failureLoadingAssignmentGroups.tr(),
            ),
          },
          (r) => r,
        );
  }
}

import 'dart:async';

import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/usecases/assignments/get_assignment_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_controller.g.dart';

@riverpod
class AssignmentController extends _$AssignmentController {
  @override
  FutureOr<Assignment> build(String assemblyId, String assignmentId) async {
    return (await ref
            .watch(getAssignmentUsecaseProvider)
            .build(
              GetAssignmentParams(
                assemblyId: assemblyId,
                assignmentId: assignmentId,
              ),
            )
            .run())
        .fold(
          (failure) => Future.error(switch (failure) {
            GetAssignmentNetworkFailure() =>
              LocaleKeys.failureLoadingAssignment.tr(),
          }),
          (assignment) => assignment,
        );
  }
}

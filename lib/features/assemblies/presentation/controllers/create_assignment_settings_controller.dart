import 'dart:async';

import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/usecases/create_assignment_settings_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_assignment_settings_controller.g.dart';

@riverpod
class CreateAssignmentSettingsController
    extends _$CreateAssignmentSettingsController {
  @override
  FutureOr<AssignmentSettings?> build(
    String assemblyId,
    String assignmentId,
  ) async {
    return null;
  }

  Future<void> createAssignmentSettings({
    required bool isRepeatingTheEntireCycle,
    required int turnDurationInDays,
    required DateTime startDateAndTime,
    required int groupSize,
  }) async {
    state = const AsyncLoading();

    final params = CreateAssignmentSettingsParams(
      assemblyId: assemblyId,
      assignmentId: assignmentId,
      isRepeatingTheEntireCycle: isRepeatingTheEntireCycle,
      turnDurationInDays: turnDurationInDays,
      startDateAndTime: startDateAndTime,
      groupSize: groupSize,
    );

    final result =
        await ref
            .read(createAssignmentSettingsUsecaseProvider)
            .build(params)
            .run();

    state = result.fold((failure) {
      final errorMessage = switch (failure) {
        AssignmentSettingsNetworkFailure() =>
          LocaleKeys.failureCreatingAssignmentSettings.tr(),
      };
      return AsyncError(errorMessage, StackTrace.current);
    }, (assignmentSettings) => AsyncData(assignmentSettings));
  }
}

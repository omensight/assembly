import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/usecases/get_assignment_settings_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_settings_controller.g.dart';

@riverpod
class AssignmentSettingsController extends _$AssignmentSettingsController {
  @override
  Future<AssignmentSettings?> build(
    String assemblyId,
    String assignmentId,
  ) async {
    final params = GetAssignmentSettingsParams(
      assemblyId: assemblyId,
      assignmentId: assignmentId,
    );

    final result =
        await ref
            .read(getAssignmentSettingsUsecaseProvider)
            .build(params)
            .run();

    return result.fold(
      (failure) => switch (failure) {
        AssignmentSettingsNetworkFailure() => Future.error(
          LocaleKeys.failureLoadingAssignmentSettings.tr(),
        ),
        AssignmentSettingsNotFoundFailure() => null,
      },
      (settings) => settings,
    );
  }
}

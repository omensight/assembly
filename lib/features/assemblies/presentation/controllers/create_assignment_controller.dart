import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/usecases/create_assignment_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_assignment_controller.g.dart';

@riverpod
class CreateAssignmentController extends _$CreateAssignmentController {
  @override
  Future<Assignment?> build() async {
    return null;
  }

  Future<void> createAssignment({
    required String assemblyId,
    required String name,
    required String description,
  }) async {
    state = const AsyncLoading();

    state = (await ref
            .read(createAssignmentUsecaseProvider)
            .build(
              CreateAssignmentParams(
                assemblyId: assemblyId,
                name: name,
                description: description,
              ),
            )
            .run())
        .fold(
          (failure) => switch (failure) {
            CreateAssignmentFailure() => AsyncError(
              LocaleKeys.failureCreatingAssignment.tr(),
              StackTrace.current,
            ),
          },
          (assignment) => AsyncData(assignment),
        );
  }
}

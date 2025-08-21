import 'package:assembly/features/assemblies/domain/usecases/assignments/confirm_assignment_group_completion_usecase.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'confirm_assignment_group_completion_controller.g.dart';

@riverpod
class ConfirmAssignmentGroupCompletionController
    extends _$ConfirmAssignmentGroupCompletionController {
  @override
  FutureOr<void> build({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
  }) async {
    return null;
  }

  Future<void> confirm() async {
    state = const AsyncLoading();
    final usecase = ref.read(confirmAssignmentGroupCompletionUsecaseProvider);

    final result =
        await usecase
            .build(
              ConfirmAssignmentGroupCompletionParams(
                assemblyId: assemblyId,
                assignmentId: assignmentId,
                assignmentGroupId: assignmentGroupId,
              ),
            )
            .run();

    state = result.fold(
      (l) => AsyncError(l, StackTrace.current),
      (r) => const AsyncData<void>(null),
    );
  }
}

import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_completion.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/usecases/assignments/mark_assignment_group_completed_usecase.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_settings_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignments_list_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_detail_provider.g.dart';

class AssignmentDetailDTO {
  final Assignment assignment;
  final AssignmentSettings? assignmentSettings;
  final List<AssignmentGroup> assignmentGroups;
  final AssemblyMemberRole assemblyMemberRole;
  AssignmentDetailDTO({
    required this.assignment,
    required this.assignmentSettings,
    required this.assignmentGroups,
    required this.assemblyMemberRole,
  });
}

@riverpod
FutureOr<AssignmentDetailDTO> assignmentDetailDTO(
  Ref ref,
  String assemblyId,
  String assignmentId,
) async {
  final assignmentAsync = await ref.watch(
    assignmentControllerProvider(assemblyId, assignmentId).future,
  );

  final assignmentSettingsAsync = await ref.watch(
    assignmentSettingsControllerProvider(assemblyId, assignmentId).future,
  );

  final assignmentGroupsAsync = await ref.watch(
    assignmentsListControllerProvider(assemblyId, assignmentId).future,
  );

  final assemblyMemberRole = ref.watch(
    currentAssemblyMemberRoleProvider(assemblyId),
  );

  return AssignmentDetailDTO(
    assignment: assignmentAsync,
    assignmentSettings: assignmentSettingsAsync,
    assignmentGroups: assignmentGroupsAsync,
    assemblyMemberRole: assemblyMemberRole,
  );
}

@riverpod
class MarkAssignmentGroupCompletedController
    extends _$MarkAssignmentGroupCompletedController {
  @override
  FutureOr<AssignmentCompletion?> build({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
  }) async {
    return null;
  }

  Future<void> markGroupAsCompleted() async {
    state = const AsyncLoading();
    final result =
        await ref
            .read(markAssignmentGroupCompletedUsecaseProvider)
            .build(
              MarkAssignmentGroupCompletedParams(
                assemblyId: assemblyId,
                assignmentId: assignmentId,
                assignmentGroupId: assignmentGroupId,
              ),
            )
            .run();
    state = result.fold(
      (l) => AsyncError(l, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}

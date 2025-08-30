import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/usecases/assignments/mark_assignment_group_completed_usecase.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_settings_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignments_list_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/presentation/providers/usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_detail_provider.g.dart';

class AssignmentDetailDTO {
  final Assignment assignment;
  final AssignmentSettings? assignmentSettings;
  final List<AssignmentGroup> assignmentGroups;
  final AssemblyMemberRole assemblyMemberRole;
  final AssemblyMember currentAssemblyMember;
  AssignmentDetailDTO({
    required this.assignment,
    required this.assignmentSettings,
    required this.assignmentGroups,
    required this.assemblyMemberRole,
    required this.currentAssemblyMember,
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

  final cycleId = assignmentAsync.activeAssignmentCycle?.id;

  final List<AssignmentGroup> assignmentGroupsAsync = cycleId != null
      ? await ref.watch(
          assignmentsListControllerProvider(
            assemblyId,
            assignmentId,
            cycleId,
          ).future,
        )
      : [];
  final currentAssemblyMember = await ref.watch(
    currentAssemblyMemberProvider(assemblyId).future,
  );

  final assemblyMemberRole = ref.watch(
    currentAssemblyMemberRoleProvider(assemblyId),
  );

  return AssignmentDetailDTO(
    assignment: assignmentAsync,
    assignmentSettings: assignmentSettingsAsync,
    assignmentGroups: assignmentGroupsAsync,
    assemblyMemberRole: assemblyMemberRole,
    currentAssemblyMember: currentAssemblyMember,
  );
}

@riverpod
class MarkAssignmentGroupCompletedController
    extends _$MarkAssignmentGroupCompletedController {
  @override
  FutureOr<bool> build({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
    required String cycleId,
  }) async {
    return false;
  }

  Future<void> markGroupAsCompleted() async {
    state = const AsyncLoading();
    final result = await ref
        .read(markAssignmentGroupCompletedUsecaseProvider)
        .build(
          MarkAssignmentGroupCompletedParams(
            assemblyId: assemblyId,
            assignmentId: assignmentId,
            assignmentGroupId: assignmentGroupId,
            cycleId: cycleId,
          ),
        )
        .run();
    state = result.fold(
      (l) => AsyncError(l, StackTrace.current),
      (r) => AsyncData(true),
    );
  }
}

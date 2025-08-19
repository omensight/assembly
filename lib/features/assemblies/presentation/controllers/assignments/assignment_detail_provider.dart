import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_settings_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignments_list_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_detail_provider.g.dart';

class AssigmentDetailDTO {
  final Assignment assignment;
  final AssignmentSettings? assignmentSettings;
  final List<AssignmentGroup> assignmentGroups;
  final AssemblyMemberRole assemblyMemberRole;
  AssigmentDetailDTO({
    required this.assignment,
    required this.assignmentSettings,
    required this.assignmentGroups,
    required this.assemblyMemberRole,
  });
}

@riverpod
FutureOr<AssigmentDetailDTO> assignmentDetailDTO(
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

  return AssigmentDetailDTO(
    assignment: assignmentAsync,
    assignmentSettings: assignmentSettingsAsync,
    assignmentGroups: assignmentGroupsAsync,
    assemblyMemberRole: assemblyMemberRole,
  );
}

import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_settings_create_request.dart';

abstract class AssignmentRepository {
  Future<Assignment> createAssignment({
    required String assemblyId,
    required AssignmentCreateRequest request,
  });

  Future<AssignmentSettings> createAssignmentSettings({
    required String assemblyId,
    required String assignmentId,
    required AssignmentSettingsCreateRequest request,
  });

  Future<List<AssignmentGroup>> getAssignmentGroups(
    String assemblyId,
    String assignmentId,
  );

  Future<Assignment> getAssignment(String assemblyId, String assignmentId);

  Future<AssignmentSettings> getAssignmentSettings(
    String assemblyId,
    String assignmentId,
  );
}

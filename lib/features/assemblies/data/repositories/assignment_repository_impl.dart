import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_settings_create_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_completion.dart';

abstract class AssignmentRemoteDataSource {
  Future<Assignment> createAssignment(
    String assemblyId,
    AssignmentCreateRequest request,
  );

  Future<AssignmentSettings> createAssignmentSettings(
    String assemblyId,
    String assignmentId,
    AssignmentSettingsCreateRequest request,
  );

  Future<List<AssignmentGroup>> getAssignmentGroups(
    String assemblyId,
    String assignmentId,
  );

  Future<Assignment> getAssignment(String assemblyId, String assignmentId);

  Future<AssignmentSettings> getAssignmentSettings(
    String assemblyId,
    String assignmentId,
  );

  Future<List<Assignment>> getAssemblyAssignments(String assemblyId);

  Future<AssignmentCompletion> markAssignmentGroupAsCompleted({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
  });

  Future<AssignmentCompletion> confirmAssignmentGroupCompletion({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
  });
}

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource _assignmentRemoteDataSource;

  AssignmentRepositoryImpl(this._assignmentRemoteDataSource);

  @override
  Future<Assignment> createAssignment({
    required String assemblyId,
    required AssignmentCreateRequest request,
  }) async {
    return await _assignmentRemoteDataSource.createAssignment(
      assemblyId,
      request,
    );
  }

  @override
  Future<AssignmentSettings> createAssignmentSettings({
    required String assemblyId,
    required String assignmentId,
    required AssignmentSettingsCreateRequest request,
  }) async {
    return await _assignmentRemoteDataSource.createAssignmentSettings(
      assemblyId,
      assignmentId,
      request,
    );
  }

  @override
  Future<List<AssignmentGroup>> getAssignmentGroups(
    String assemblyId,
    String assignmentId,
  ) {
    return _assignmentRemoteDataSource.getAssignmentGroups(
      assemblyId,
      assignmentId,
    );
  }

  @override
  Future<Assignment> getAssignment(String assemblyId, String assignmentId) {
    return _assignmentRemoteDataSource.getAssignment(assemblyId, assignmentId);
  }

  @override
  Future<AssignmentSettings> getAssignmentSettings(
    String assemblyId,
    String assignmentId,
  ) {
    return _assignmentRemoteDataSource.getAssignmentSettings(
      assemblyId,
      assignmentId,
    );
  }

  @override
  Future<List<Assignment>> getAssemblyAssignments(String assemblyId) {
    return _assignmentRemoteDataSource.getAssemblyAssignments(assemblyId);
  }

  @override
  Future<AssignmentCompletion> markAssignmentGroupAsCompleted({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
  }) {
    return _assignmentRemoteDataSource.markAssignmentGroupAsCompleted(
      assemblyId: assemblyId,
      assignmentId: assignmentId,
      assignmentGroupId: assignmentGroupId,
    );
  }

  @override
  Future<AssignmentCompletion> confirmAssignmentGroupCompletion({
    required String assemblyId,
    required String assignmentId,
    required String assignmentGroupId,
  }) {
    return _assignmentRemoteDataSource.confirmAssignmentGroupCompletion(
      assemblyId: assemblyId,
      assignmentId: assignmentId,
      assignmentGroupId: assignmentGroupId,
    );
  }
}

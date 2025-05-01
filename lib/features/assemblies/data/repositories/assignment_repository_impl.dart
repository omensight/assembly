import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_settings.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_settings_create_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';

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
}

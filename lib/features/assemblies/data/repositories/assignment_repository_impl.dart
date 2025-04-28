import 'package:assembly/features/assemblies/data/data_sources/assignment_remote_data_source.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assignment_repository.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource _remoteDataSource;

  AssignmentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Assignment> createAssignment({
    required String assemblyId,
    required AssignmentCreateRequest request,
  }) async {
    return await _remoteDataSource.createAssignment(assemblyId, request);
  }
}

import 'package:assembly/features/assemblies/domain/entities/assignment.dart';
import 'package:assembly/features/assemblies/domain/models/assignment_create_request.dart';

abstract class AssignmentRemoteDataSource {
  Future<Assignment> createAssignment(
    String assemblyId,
    AssignmentCreateRequest request,
  );
}

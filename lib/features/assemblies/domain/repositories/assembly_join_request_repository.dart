import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_join_request_body_request.dart';

abstract interface class AssemblyJoinRequestRepository {
  Future<AssemblyJoinRequest> postAssemblyJoinRequest(
    String assemblyId,
    AssemblyJoinRequestBodyRequest assemblyJoinRequestBodyRequest,
  );

  Future<List<AssemblyJoinRequest>> getAssemblyJoinRequests(String assemblyId);

  Future<void> acceptJoinRequest(String assemblyId, String joinRequestId);
}

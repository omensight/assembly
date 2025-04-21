import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_join_request_body_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';

abstract interface class AssemblyJoinRequestRemoteDataSource {
  Future<AssemblyJoinRequest> postAssemblyJoinRequest(
    String assemblyId,
    AssemblyJoinRequestBodyRequest assemblyJoinRequestBodyRequest,
  );

  Future<List<AssemblyJoinRequest>> getAssemblyJoinRequests(String assemblyId);

  Future<void> acceptJoinRequest(String assemblyId, String joinRequestId);
}

class AssemblyJoinRequestRepositoryImpl
    implements AssemblyJoinRequestRepository {
  final AssemblyJoinRequestRemoteDataSource
  _assembleJoinRequestRemoteDataSource;

  AssemblyJoinRequestRepositoryImpl({
    required AssemblyJoinRequestRemoteDataSource
    assembleJoinRequestRemoteDataSource,
  }) : _assembleJoinRequestRemoteDataSource =
           assembleJoinRequestRemoteDataSource;

  @override
  Future<AssemblyJoinRequest> postAssemblyJoinRequest(
    String assemblyId,
    AssemblyJoinRequestBodyRequest assemblyJoinRequestBodyRequest,
  ) => _assembleJoinRequestRemoteDataSource.postAssemblyJoinRequest(
    assemblyId,
    assemblyJoinRequestBodyRequest,
  );

  @override
  Future<List<AssemblyJoinRequest>> getAssemblyJoinRequests(
    String assemblyId,
  ) => _assembleJoinRequestRemoteDataSource.getAssemblyJoinRequests(assemblyId);

  @override
  Future<void> acceptJoinRequest(String assemblyId, String joinRequestId) =>
      _assembleJoinRequestRemoteDataSource.acceptJoinRequest(
        assemblyId,
        joinRequestId,
      );
}

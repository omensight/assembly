import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/domain/models/assembly_join_request_body_request.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_join_request_repository.dart';

abstract interface class AssemblyJoinRequestRemoteDataSource {
  Future<AssemblyJoinRequest> postAssemblyJoinRequest(
    String assemblyId,
    AssemblyJoinRequestBodyRequest assemblyJoinRequestBodyRequest,
  );
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
}

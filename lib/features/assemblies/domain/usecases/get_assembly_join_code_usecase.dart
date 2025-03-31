import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_code.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssemblyJoinCodeUsecase
    extends Usecase<AssemblyJoinCode, GetAssemblyJoinCodeParams> {
  final AssemblyRepository _assemblyRepository;

  GetAssemblyJoinCodeUsecase({required AssemblyRepository assemblyRepository})
    : _assemblyRepository = assemblyRepository;
  @override
  TaskEither<Failure, AssemblyJoinCode> build(
    GetAssemblyJoinCodeParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyRepository.getAssemblyJoinCode(
        params.assemblyId,
        params.refresh,
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class GetAssemblyJoinCodeParams extends Params {
  final String assemblyId;
  final bool refresh;

  GetAssemblyJoinCodeParams({required this.assemblyId, required this.refresh});
}

class GetAssemblyJoinCodeFailure extends Failure {}

class NetworkFailure extends GetAssemblyJoinCodeFailure {}

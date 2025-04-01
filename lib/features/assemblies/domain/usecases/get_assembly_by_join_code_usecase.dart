import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssemblyByJoinCodeUsecase
    implements Usecase<Assembly, GetAssemblyByJoinCodeParams> {
  final AssemblyRepository assemblyRepository;

  GetAssemblyByJoinCodeUsecase({required this.assemblyRepository});
  @override
  TaskEither<GetAssemblyByJoinCodeFailure, Assembly> build(
    GetAssemblyByJoinCodeParams params,
  ) {
    return TaskEither.tryCatch(
      () => assemblyRepository.getAssemblyByJoinCode(params.joinCode),
      (_, _) => NetworkFailure(),
    );
  }
}

class GetAssemblyByJoinCodeParams extends Params {
  final String joinCode;

  GetAssemblyByJoinCodeParams({required this.joinCode});
}

sealed class GetAssemblyByJoinCodeFailure extends Failure {}

class NetworkFailure extends GetAssemblyByJoinCodeFailure {}

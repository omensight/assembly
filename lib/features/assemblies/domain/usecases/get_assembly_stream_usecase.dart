import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssemblyStreamUsecase
    implements SyncUsecase<Stream<Assembly?>, GetAssemblyStreamParams> {
  final AssemblyRepository assemblyRepository;

  GetAssemblyStreamUsecase({required this.assemblyRepository});
  @override
  Either<GetAssemblyStreamFailure, Stream<Assembly?>> call(
    GetAssemblyStreamParams params,
  ) {
    return Either.tryCatch(
      () => assemblyRepository.getAssemblyStream(params.assemblyId),
      (_, _) => GetAssemblyStreamFailure(),
    );
  }
}

class GetAssemblyStreamParams extends Params {
  final String assemblyId;

  GetAssemblyStreamParams({required this.assemblyId});
}

class GetAssemblyStreamFailure extends Failure {}

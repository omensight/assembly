import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/domain/repositories/assembly_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAssembliesListStreamUsecase
    implements
        SyncUsecase<Stream<List<Assembly>>, GetAssembliesListStreamParams> {
  final AssemblyRepository assemblyRepository;

  GetAssembliesListStreamUsecase({required this.assemblyRepository});
  @override
  Either<GetAssembliesListStreamFailure, Stream<List<Assembly>>> call(
    GetAssembliesListStreamParams params,
  ) {
    return Either.tryCatch(
      () => assemblyRepository.getUserAssembliesStream(params.userId),
      (_, _) => GetAssembliesListStreamFailure(),
    );
  }
}

class GetAssembliesListStreamParams extends Params {
  final int userId;

  GetAssembliesListStreamParams({required this.userId});
}

class GetAssembliesListStreamFailure extends Failure {}

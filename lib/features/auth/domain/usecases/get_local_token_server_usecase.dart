import 'package:fpdart/fpdart.dart';
import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:assembly/features/auth/domain/repositories/server_token_repository.dart';

class GetLocalTokenServerUsecase
    extends SyncUsecase<Stream<ServerToken?>, NoParams> {
  GetLocalTokenServerUsecase({
    required ServerTokenRepository serverTokenRepository,
  }) : _serverTokenRepository = serverTokenRepository;

  final ServerTokenRepository _serverTokenRepository;

  @override
  Either<Failure, Stream<ServerToken?>> call(NoParams params) {
    return Either.tryCatch(
      () => _serverTokenRepository.getServerTokenStream(),
      (error, stackTrace) => InvalidServerToken(),
    );
  }
}

class GetLocalTokenServerParams extends Params {
  GetLocalTokenServerParams({required this.firebaseIdToken});

  final String firebaseIdToken;
}

sealed class GetLocalTokenServerFailure extends Failure {}

class InvalidServerToken extends GetLocalTokenServerFailure {}

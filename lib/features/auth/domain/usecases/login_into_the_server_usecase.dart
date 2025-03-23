import 'package:fpdart/fpdart.dart';
import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:assembly/features/auth/domain/repositories/server_token_repository.dart';

class LoginIntoTheServerUsecase
    extends Usecase<ServerToken, LoginIntoTheServerParams> {
  LoginIntoTheServerUsecase({
    required ServerTokenRepository serverTokenRepository,
  }) : _serverTokenRepository = serverTokenRepository;

  final ServerTokenRepository _serverTokenRepository;

  @override
  TaskEither<Failure, ServerToken> build(LoginIntoTheServerParams params) {
    return TaskEither.tryCatch(
      () => _serverTokenRepository.getServerToken(
        firebaseIdToken: params.firebaseIdToken,
      ),
      (error, stackTrace) => InvalidCredentials(),
    );
  }
}

class LoginIntoTheServerParams extends Params {
  LoginIntoTheServerParams({required this.firebaseIdToken});

  final String firebaseIdToken;
}

sealed class LoginFailure extends Failure {}

class InvalidCredentials extends LoginFailure {}

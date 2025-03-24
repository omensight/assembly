import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';

class SignInUsingEmailAndPasswordUsecase
    extends Usecase<UserCredential, SignInUsingEmailAndPasswordParams> {
  @override
  TaskEither<SignInUsingEmailAndPasswordFailure, UserCredential> build(
    SignInUsingEmailAndPasswordParams params,
  ) {
    return TaskEither.tryCatch(
      () => FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.emailAddress,
        password: params.password,
      ),
      (error, stackTrace) => InvalidCredentials(),
    );
  }
}

class SignInUsingEmailAndPasswordParams extends Params {
  final String emailAddress;
  final String password;

  SignInUsingEmailAndPasswordParams({
    required this.emailAddress,
    required this.password,
  });
}

sealed class SignInUsingEmailAndPasswordFailure extends Failure {}

class InvalidCredentials extends SignInUsingEmailAndPasswordFailure {}

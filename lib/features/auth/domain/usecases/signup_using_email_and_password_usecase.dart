import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';

class SignUpUsingEmailAndPasswordUsecase
    extends Usecase<UserCredential, SignUpUsingEmailAndPasswordParams> {
  @override
  TaskEither<SignUpUsingEmailAndPasswordFailure, UserCredential> build(
    SignUpUsingEmailAndPasswordParams params,
  ) {
    return TaskEither.tryCatch(
      () => FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.emailAddress,
        password: params.password,
      ),
      (error, stackTrace) {
        SignUpUsingEmailAndPasswordFailure failure = CannotSignUp();
        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'email-already-in-use':
              failure = EmailAlreadyInUse();
              break;
            case 'weak-password':
              failure = WeakPassword();
              break;
            default:
              break;
          }
        }
        return failure;
      },
    );
  }
}

class SignUpUsingEmailAndPasswordParams extends Params {
  final String emailAddress;
  final String password;

  SignUpUsingEmailAndPasswordParams({
    required this.emailAddress,
    required this.password,
  });
}

sealed class SignUpUsingEmailAndPasswordFailure extends Failure {}

class CannotSignUp extends SignUpUsingEmailAndPasswordFailure {}

class WeakPassword extends SignUpUsingEmailAndPasswordFailure {}

class EmailAlreadyInUse extends SignUpUsingEmailAndPasswordFailure {}

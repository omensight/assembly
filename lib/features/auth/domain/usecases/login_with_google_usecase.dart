import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:assembly/core/error/failure.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/core/usecase/usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogleUsecase extends Usecase<UserCredential, NoParams> {
  @override
  TaskEither<Failure, UserCredential> build(NoParams params) {
    return TaskEither.tryCatch(() async {
      final GoogleSignInAccount? googleAccount =
          await GoogleSignIn(scopes: []).signIn();
      final GoogleSignInAuthentication? signInAuthentication =
          await googleAccount?.authentication;

      var accessToken = signInAuthentication?.accessToken;
      if (accessToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: accessToken,
        );

        var userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        return userCredential;
      } else {
        throw Exception('Cannot obtain credentials');
      }
    }, (error, stackTrace) => CannotObtainCredentials());
  }
}

sealed class LoginWithGoogleFailure extends Failure {}

class CannotObtainCredentials extends LoginWithGoogleFailure {}

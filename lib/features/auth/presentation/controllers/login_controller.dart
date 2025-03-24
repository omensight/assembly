import 'package:assembly/features/auth/domain/models/authentication_state.dart';
import 'package:assembly/features/auth/domain/usecases/sigin_using_email_and_password_usecase.dart';
import 'package:assembly/features/auth/domain/usecases/signup_using_email_and_password_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:assembly/core/usecase/params.dart';
import 'package:assembly/features/auth/domain/entities/server_token.dart';
import 'package:assembly/features/auth/domain/usecases/login_into_the_server_usecase.dart';
import 'package:assembly/features/auth/presentation/providers/usecase_providers.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'login_controller.g.dart';

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  return FirebaseAuth.instance.authStateChanges();
}

@Riverpod(keepAlive: true)
FutureOr<ServerToken?> serverToken(Ref ref) async {
  final loggedInUser = ref
      .watch(loginControllerProvider)
      .when(
        data: (data) => data,
        error: (error, stackTrace) => null,
        loading: () => null,
      );
  ServerToken? serverToken;
  if (loggedInUser != null) {
    final idToken = await loggedInUser.getIdToken();
    if (idToken != null) {
      serverToken = (await ref
              .read(loginIntoTheServerUsecaseProvider)
              .build(LoginIntoTheServerParams(firebaseIdToken: idToken))
              .run())
          .fold((l) => null, (r) => serverToken = r);
    }
  }
  return serverToken;
}

@riverpod
AuthenticationState authenticationState(Ref ref) {
  return ref
      .watch(serverTokenProvider)
      .when(
        data:
            (data) =>
                data != null
                    ? AuthenticationState.authenticated
                    : AuthenticationState.unauthenticated,
        error: (error, stackTrace) => AuthenticationState.unauthenticated,
        loading: () => AuthenticationState.unauthenticated,
      );
}

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<User?> build() {
    return ref
        .watch(authStateChangesProvider)
        .when(
          data: (data) => data,
          error: (error, stackTrace) => null,
          loading: () => null,
        );
  }

  Future<void> loginWithGoogle() async {
    (await ref.watch(loginWithGoogleUsecaseProvider).build(NoParams()).run())
        .fold((l) {
          state = AsyncError(
            LocaleKeys.authenticationFailure.tr(),
            StackTrace.current,
          );
        }, (_) {});
  }

  Future<void> registerUsingEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    (await ref
            .read(signInUsingEmailAndPasswordUsecaseProvider)
            .build(
              SignInUsingEmailAndPasswordParams(
                emailAddress: emailAddress,
                password: password,
              ),
            )
            .run())
        .fold((l) async {
          (await ref
                  .read(signUpUsingEmailAndPasswordUsecaseProvider)
                  .build(
                    SignUpUsingEmailAndPasswordParams(
                      emailAddress: emailAddress,
                      password: password,
                    ),
                  )
                  .run())
              .fold((l) {
                state = AsyncError(switch (l) {
                  CannotSignUp() => LocaleKeys.cannotRegister.tr(),
                  EmailAlreadyInUse() => LocaleKeys.wrongPassword.tr(),
                  WeakPassword() => LocaleKeys.weakPassword.tr(),
                }, StackTrace.current);
              }, (r) => AsyncData(r.user));
        }, (_) {});
  }
}

import 'package:assembly/core/constants.dart';
import 'package:assembly/core/text_validators/login_text_validator.dart';
import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_form_field_password.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:assembly/features/auth/presentation/controllers/login_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next as String)));
      }
    });
    final loginTextValidator = useMemoized(() => LoginTextValidator());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final loginWithEmailInProgress = useState(false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kStandardPadding),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 72),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.welcomeBack.tr(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(LocaleKeys.pleaseSignInToContinue.tr()),
                  ],
                ),
                const StandardSpace.vertical(space: 24),
                SignInWithGoogleButton(),
                const StandardSpace.vertical(space: 24),
                Text(
                  LocaleKeys.enterYourEmailAndPassword.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  LocaleKeys.ifYouDoNotHaveAnAccountWithUsWeWillCreateOneForYou
                      .tr(),
                ),
                const StandardSpace.vertical(),

                StandardTextFormField(
                  controller: emailController,
                  label: LocaleKeys.email.tr(),
                  validator: (value) =>
                      loginTextValidator.emailValidator(value),
                  onChanged: (value) {},
                ),
                const StandardSpace.vertical(),
                StandardFormFieldPassword(
                  controller: passwordController,
                  label: LocaleKeys.password.tr(),
                  validator: (value) =>
                      loginTextValidator.passwordValidator(value),
                  onChanged: (value) {},
                ),
                const StandardSpace.vertical(),
                SizedBox(
                  width: double.infinity,
                  child: StandardButton(
                    text: LocaleKeys.signIn.tr(),
                    isBackgroundColored: true,
                    onPressed: loginWithEmailInProgress.value
                        ? null
                        : () async {
                            loginWithEmailInProgress.value = true;
                            final isValid =
                                formKey.currentState?.validate() ?? false;
                            if (isValid) {
                              await ref
                                  .read(loginControllerProvider.notifier)
                                  .registerUsingEmailAndPassword(
                                    emailAddress: emailController.text,
                                    password: passwordController.text,
                                  );
                            }
                            try {
                              loginWithEmailInProgress.value = false;
                            } catch (_) {}
                          },
                    buttonState: loginWithEmailInProgress.value
                        ? StandardButtonState.loading
                        : StandardButtonState.standBy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInWithGoogleButton extends HookConsumerWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInWithGoogleInProgress = useState(false);
    return ElevatedButton.icon(
      onPressed: signInWithGoogleInProgress.value
          ? null
          : () async {
              signInWithGoogleInProgress.value = true;
              await ref
                  .read(loginControllerProvider.notifier)
                  .loginWithGoogle();
              signInWithGoogleInProgress.value = true;
            },
      label: Row(
        spacing: 8,
        children: [
          signInWithGoogleInProgress.value
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(),
                )
              : Image.asset('assets/icons/google_logo.png', width: 24),
          Text(LocaleKeys.signInGoogle.tr()),
        ],
      ),
    );
  }
}

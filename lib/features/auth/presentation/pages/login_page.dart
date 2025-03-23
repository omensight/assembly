import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:assembly/features/auth/presentation/controllers/login_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginControllerProvider, (previous, next) {
      switch (next) {
        case AsyncError(:final error):
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error as String)));
      }
    });
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            ref.read(loginControllerProvider.notifier).loginWithGoogle();
          },
          label: Row(
            spacing: 8,
            children: [
              Image.asset('assets/icons/google_logo.png', width: 24),
              Text(LocaleKeys.logInWithGoogle.tr()),
            ],
          ),
        ),
      ),
    );
  }
}

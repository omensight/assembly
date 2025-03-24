import 'package:easy_localization/easy_localization.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class LoginTextValidator {
  String? passwordValidator(String? value) {
    String? error;
    final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$');
    if (value == null || !regex.hasMatch(value)) {
      error = LocaleKeys.errorInvalidPassword.tr();
    }
    return error;
  }

  String? emailValidator(String? value) {
    String? error;

    final regex = RegExp(
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""",
    );
    if (value == null || !regex.hasMatch(value)) {
      error = LocaleKeys.failureInvalidEmail.tr();
    }

    if (value == null || value.isEmpty) {
      error = LocaleKeys.errorRequiredField.tr();
    }
    return error;
  }

  String? usernameValidator(String? value, bool isUsernameAvailable) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errorRequiredField.tr();
    }

    if (isUsernameAvailable) {
      return 'error_username_already_in_use'.tr();
    }

    final usernameRegex = RegExp(
      r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
    );
    if (!usernameRegex.hasMatch(value) || value.length > 30) {
      throw Exception('Not implemented');
    }
    return null;
  }

  String? passwordMatchingValidator(
    String? value,
    String? password,
    bool validatePassword,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.errorRequiredField.tr();
    }

    if (validatePassword) {
      final passwordValidation = passwordValidator(value);
      if (passwordValidation != null) {
        return passwordValidation;
      }
    }

    if (value != password) {
      throw Exception('Not implemented');
    }
    return null;
  }
}

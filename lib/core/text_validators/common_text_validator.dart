import 'package:easy_localization/easy_localization.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class CommonTextValidator {
  String? requiredField(String? value, {String? errorMessage}) {
    String? error;
    if (value == null || value.isEmpty) {
      error = errorMessage ?? LocaleKeys.errorRequiredField.tr();
    }
    return error;
  }

  String? requiredObjectField(Object? value, {String? errorMessage}) {
    String? error;
    if (value == null) {
      error = errorMessage ?? LocaleKeys.errorRequiredField.tr();
    }
    return error;
  }

  String? validatePhoneNumber(String? value) {
    String? error;
    RegExp regex = RegExp(r'^(?:6\d{7}|7\d{7}|4\d{6}|3\d{6}|2\d{6}|\+\d+)$');
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      error = LocaleKeys.invalidPhoneNumber.tr();
    }
    return error;
  }

  String? minimumLength(String? value, int minLength) {
    String? error;
    if (value == null || value.length < minLength) {
      error = LocaleKeys.errorMinimumLength.tr(args: [minLength.toString()]);
    }
    return error;
  }
}

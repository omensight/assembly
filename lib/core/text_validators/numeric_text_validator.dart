import 'package:easy_localization/easy_localization.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class NumericTextValidator {
  String? valueCannotBeGreaterTo(String? value, int max) {
    String? error;
    if (value == null || value.isEmpty) {
      error = LocaleKeys.errorRequiredField.tr();
    } else {
      int intValue = int.tryParse(value) ?? 0;
      if (intValue > max) {
        error = LocaleKeys.failureValueExceedsTheMaxValue.tr(
          args: [max.toString()],
        );
      }
    }
    return error;
  }

  String? atLeastOneNonZero(
    String? value1,
    String? value2,
    String? errorMessage,
  ) {
    bool isValue1Zero =
        value1 == null || int.tryParse(value1) == 0 || value1.isEmpty;
    bool isValue2Zero =
        value2 == null || int.tryParse(value2) == 0 || value2.isEmpty;
    if (isValue1Zero && isValue2Zero) {
      return errorMessage ?? LocaleKeys.errorAtLeastOneNonZeroField.tr();
    }
    return null;
  }
}

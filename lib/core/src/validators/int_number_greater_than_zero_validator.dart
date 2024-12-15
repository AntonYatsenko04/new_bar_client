import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core/src/validators/validator.dart';
import 'package:easy_localization/easy_localization.dart';

class IntNumberGreaterThanZeroValidator implements Validator {
  const IntNumberGreaterThanZeroValidator();

  @override
  String? check(String? value) {
    final String? trimmedValue = value?.trim();

    final int? num = int.tryParse(trimmedValue ?? '');

    if (num == null) {
      return LocaleKeys.commonErrors_invalidInput.tr();
    }

    if (num <= 0) {
      return LocaleKeys.commonErrors_valueMustBeGreaterThanZero.tr();
    }

    return null;
  }
}

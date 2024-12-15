import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core/src/validators/validator.dart';
import 'package:easy_localization/easy_localization.dart';

class EmptyFieldValidator implements Validator {
  const EmptyFieldValidator();

  @override
  String? check(String? value) {
    final String? trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return LocaleKeys.commonErrors_fieldCantBeEmpty.tr();
    }

    return null;
  }
}

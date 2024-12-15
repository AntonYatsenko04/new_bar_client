import 'package:bar_client/core/src/constants/config_constants.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core/src/validators/validator.dart';

class PasswordValidator implements Validator {
  const PasswordValidator();

  @override
  String? check(String? value) {
    if (value == null || value.length < 8 || value.length > 16) {
      return LocaleKeys.auth_passwordLengthCondition;
    }
    if (!RegExp(ConfigConstants.alphaNumericRegExp).hasMatch(value)) {
      return LocaleKeys.auth_passwordContentCondition;
    }

    return null;
  }
}

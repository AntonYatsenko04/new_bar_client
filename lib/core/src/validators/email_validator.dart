import 'package:bar_client/core/src/constants/config_constants.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core/src/validators/validator.dart';

class EmailValidator implements Validator {
  const EmailValidator();

  @override
  String? check(String? value) {
    if (value == null ||
        value.isEmpty ||
        !RegExp(ConfigConstants.emailRegExpString).hasMatch(value)) {
      return LocaleKeys.auth_invalidEmailWarning;
    }
    return null;
  }
}

import 'package:bar_client/core/src/validators/validator.dart';

class ValidatorUnion implements Validator {
  final List<Validator> _validators;

  ValidatorUnion({
    required List<Validator> validators,
  }) : _validators = validators;

  @override
  String? check(String? value) {
    for (final Validator validator in _validators) {
      final String? error = validator.check(value);
      if (error != null) {
        return error;
      }
    }

    return null;
  }
}

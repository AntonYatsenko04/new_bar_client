import 'package:freezed_annotation/freezed_annotation.dart';

import '../localization/generated/locale_keys.g.dart';

@JsonEnum(valueField: 'apiCode')
enum UserType {
  manager(localeKey: LocaleKeys.roles_manager, apiCode: 'manager'),
  waiter(localeKey: LocaleKeys.roles_waiter, apiCode: 'waiter'),
  cook(localeKey: LocaleKeys.roles_cook, apiCode: 'cook');

  final String localeKey;
  final String apiCode;

  const UserType({
    required this.localeKey,
    required this.apiCode,
  });
}

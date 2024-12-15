import 'dart:ui';

sealed class AppLocalization {
  static const List<Locale> supportedLocales = <Locale>[Locale('ru', 'RU')];
  static const String localePath = 'assets/translations';
  static const Locale ruLocale = Locale('ru', 'RU');
  static const String ruLocaleString = 'ru';
}

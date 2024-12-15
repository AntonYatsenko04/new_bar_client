import 'package:bar_client/core/src/localization/app_localization.dart';
import 'package:easy_localization/easy_localization.dart';

sealed class NumberFormatters {
  static final NumberFormat _formatCurrency = NumberFormat.simpleCurrency(
    locale: AppLocalization.ruLocaleString,
  );

  static String formatCurrency(int value) {
    return _formatCurrency.format(value / 100);
  }
}

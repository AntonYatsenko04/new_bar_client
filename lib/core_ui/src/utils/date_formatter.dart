import 'package:easy_localization/easy_localization.dart';

sealed class DateFormatter {
  static String getDateTimeString(DateTime dateTime) {
    return "${DateFormat.yMMMMEEEEd('ru').format(dateTime)} ${DateFormat.jms('ru').format(dateTime)}";
  }

  static String getDateString(DateTime dateTime) {
    return DateFormat.yMMMMEEEEd('ru').format(dateTime);
  }

  static String getTimeString(DateTime dateTime) {
    return DateFormat.jms('ru').format(dateTime);
  }
}

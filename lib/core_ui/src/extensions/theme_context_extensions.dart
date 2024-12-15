import 'package:bar_client/core_ui/src/theme/color/app_colors_theme.dart';
import 'package:flutter/material.dart';

extension ColorsContextExtension on ThemeData {
  AppColorsTheme get colors {
    return extension<AppColorsTheme>()!;
  }
}

extension TextContextExtension on ThemeData {
  TextTheme get text {
    return textTheme;
  }
}

extension ThemeDataExtension on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }
}

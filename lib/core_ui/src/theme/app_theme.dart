import 'package:bar_client/core_ui/src/extensions/theme_context_extensions.dart';
import 'package:bar_client/core_ui/src/theme/app_dimens.dart';
import 'package:bar_client/core_ui/src/theme/app_text_styles.dart';
import 'package:bar_client/core_ui/src/theme/color/app_colors_theme.dart';
import 'package:bar_client/core_ui/src/theme/color/light_colors_theme.dart';
import 'package:flutter/material.dart';

part 'app_button_themes.dart';

final ThemeData lightTheme = _buildThemeData(
  base: ThemeData.light().copyWith(
    extensions: <ThemeExtension<AppColorsTheme>>[
      const LightColorsTheme(),
    ],
  ),
);

ThemeData _buildThemeData({
  required ThemeData base,
}) {
  final AppColorsTheme colors = base.colors;
  final TextTheme appTextTheme = _getTextTheme(colors);

  return base.copyWith(
    scaffoldBackgroundColor: colors.background,
    appBarTheme: _getAppBarTheme(
      colors,
      appTextTheme,
    ),
    pageTransitionsTheme: _getPageTransitionsTheme(),
    textTheme: appTextTheme,
    textButtonTheme: _getTextButtonThemeData(colors),
    inputDecorationTheme: _getInputDecorationTheme(colors),
    filledButtonTheme: _getFilledButtonTheme(colors),
    outlinedButtonTheme: _getOutlinedButtonThemeData(colors),
    dividerTheme: _getDividerThemeData(colors),
  );
}

AppBarTheme _getAppBarTheme(
  AppColorsTheme colors,
  TextTheme textTheme,
) {
  return AppBarTheme(
    backgroundColor: colors.background,
    titleTextStyle: AppTextStyles.s18W500H24Regular.copyWith(
      color: colors.textColor,
    ),
    centerTitle: true,
  );
}

TextTheme _getTextTheme(AppColorsTheme colors) {
  return TextTheme(
    displaySmall: AppTextStyles.s28W600H34Regular.copyWith(
      color: colors.textColor,
    ),
    headlineLarge: AppTextStyles.s30W600H36Regular.copyWith(color: colors.textColor),
    headlineMedium: AppTextStyles.s22W500H28Regular.copyWith(color: colors.textColor),
    headlineSmall: AppTextStyles.s18W500H24Regular.copyWith(color: colors.textColor),
    titleLarge: AppTextStyles.s16W600H22Regular.copyWith(color: colors.textColor),
    titleMedium: AppTextStyles.s16W400H22Regular.copyWith(color: colors.textColor),
    bodyLarge: AppTextStyles.s16W400H22Regular.copyWith(color: colors.textColor),
    bodyMedium: AppTextStyles.s14W400H18Regular.copyWith(color: colors.textColor),
    bodySmall: AppTextStyles.s10W400H12Regular.copyWith(color: colors.textColor),
    labelLarge: AppTextStyles.s16W600H20Regular.copyWith(color: colors.textColor),
    labelMedium: AppTextStyles.s16W500H20Regular.copyWith(color: colors.textColor),
    labelSmall: AppTextStyles.s12W500H14Regular.copyWith(color: colors.textColor),
  );
}

InputDecorationTheme _getInputDecorationTheme(AppColorsTheme colors) {
  return InputDecorationTheme(
    hintStyle: AppTextStyles.s16W400H22Regular.copyWith(color: colors.textHint),
    contentPadding: const EdgeInsets.symmetric(
      vertical: AppDimens.padding14,
      horizontal: AppDimens.padding16,
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: colors.textHint,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: colors.primary,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: colors.error,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.borderRadius12),
      ),
      borderSide: BorderSide(
        color: colors.error,
      ),
    ),
    floatingLabelStyle: AppTextStyles.s8W400Regular,
  );
}

PageTransitionsTheme _getPageTransitionsTheme() {
  return const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(
        allowEnterRouteSnapshotting: false,
      ),
    },
  );
}

DividerThemeData _getDividerThemeData(AppColorsTheme colors) {
  return const DividerThemeData(
    space: AppDimens.height8,
  );
}

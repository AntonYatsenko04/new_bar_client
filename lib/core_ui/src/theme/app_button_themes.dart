part of 'app_theme.dart';

FilledButtonThemeData _getFilledButtonTheme(AppColorsTheme colors) {
  final ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return colors.filledButtonActiveBackground;
        } else if (states.contains(WidgetState.disabled)) {
          return colors.filledButtonDisabledBackground;
        }
        return colors.filledButtonBackground;
      },
    ),
    foregroundColor: WidgetStatePropertyAll<Color>(
      colors.filledButtonForeground,
    ),
    padding: const WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(
        vertical: AppDimens.padding16,
        horizontal: AppDimens.padding50,
      ),
    ),
    textStyle: WidgetStatePropertyAll<TextStyle>(
      AppTextStyles.s16W600H20Regular.copyWith(
        color: colors.filledButtonForeground,
      ),
    ),
  );

  return FilledButtonThemeData(style: buttonStyle);
}

TextButtonThemeData _getTextButtonThemeData(AppColorsTheme colors) {
  final ButtonStyle buttonStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    splashFactory: NoSplash.splashFactory,
    padding: const WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.zero,
    ),
    overlayColor: WidgetStatePropertyAll<Color>(
      colors.textButtonOverlay,
    ),
    foregroundColor: WidgetStateProperty.resolveWith(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return colors.textButtonPressedColor;
        } else if (states.contains(WidgetState.disabled)) {
          return colors.textButtonDisabledColor;
        }
        return colors.textButtonForeground;
      },
    ),
    textStyle: const WidgetStatePropertyAll<TextStyle?>(
      AppTextStyles.s16W500H20Regular,
    ),
  );

  return TextButtonThemeData(style: buttonStyle);
}

OutlinedButtonThemeData _getOutlinedButtonThemeData(AppColorsTheme colors) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: AppDimens.padding12,
          horizontal: AppDimens.padding20,
        ),
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (Set<WidgetState> states) {
          final Color borderColor;
          if (states.contains(WidgetState.pressed)) {
            borderColor = colors.outlinedButtonPressedForeground;
          } else if (states.contains(WidgetState.disabled)) {
            borderColor = colors.outlinedButtonDisabledForeground;
          } else {
            borderColor = colors.outlinedButtonForeground;
          }

          return BorderSide(color: borderColor);
        },
      ),
      overlayColor: WidgetStatePropertyAll<Color>(colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return colors.outlinedButtonPressedForeground;
          } else if (states.contains(WidgetState.disabled)) {
            return colors.outlinedButtonDisabledForeground;
          }
          return colors.outlinedButtonForeground;
        },
      ),
      textStyle: const WidgetStatePropertyAll<TextStyle>(
        AppTextStyles.s16W500H20Regular,
      ),
    ),
  );
}

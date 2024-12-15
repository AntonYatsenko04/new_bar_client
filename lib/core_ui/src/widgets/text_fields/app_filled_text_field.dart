import 'package:bar_client/core_ui/src/extensions/theme_context_extensions.dart';
import 'package:bar_client/core_ui/src/theme/app_dimens.dart';
import 'package:bar_client/core_ui/src/theme/color/app_colors_theme.dart';
import 'package:flutter/material.dart';

class AppFilledTextField extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final TextStyle? style;
  final Color? color;

  const AppFilledTextField({
    required this.text,
    this.padding,
    this.style,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    final AppColorsTheme colors = theme.colors;
    final TextTheme textTheme = theme.text;

    return Container(
      color: color ?? colors.filledTextFieldBackground,
      padding: padding ?? const EdgeInsets.all(AppDimens.padding16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: style ?? textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

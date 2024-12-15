import 'package:bar_client/core_ui/src/extensions/theme_context_extensions.dart';
import 'package:bar_client/core_ui/src/theme/app_dimens.dart';
import 'package:bar_client/core_ui/src/theme/app_text_styles.dart';
import 'package:bar_client/core_ui/src/theme/color/app_colors_theme.dart';
import 'package:bar_client/core_ui/src/widgets/text_fields/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFieldWithLabel extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hintText;
  final String? errorText;
  final Widget? error;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextFieldWithLabel({
    required this.label,
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.error,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final AppColorsTheme colors = Theme.of(context).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.s16W600Regular.copyWith(color: colors.textColor),
        ),
        const SizedBox(
          height: AppDimens.margin4,
        ),
        AppTextField(
          key: key,
          controller: controller,
          validator: validator,
          autovalidateMode: autovalidateMode,
          hintText: hintText,
          errorText: errorText,
          error: error,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final Widget? error;
  final Color? borderColor;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool? autoCorrect;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.error,
    this.borderColor,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.keyboardType,
    this.autoCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        key: key,
        autovalidateMode: autovalidateMode,
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.start,
          errorMaxLines: 5,
          hintText: hintText,
          errorText: errorText,
          error: error,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        obscureText: obscureText,
        onChanged: onChanged,
        keyboardType: keyboardType,
        autocorrect: autoCorrect ?? false,
      ),
    );
  }
}

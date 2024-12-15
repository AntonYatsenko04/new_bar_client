import 'package:bar_client/core_ui/src/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: AppTextStyles.s18W500H24Regular.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}

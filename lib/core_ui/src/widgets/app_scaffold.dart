import 'package:bar_client/core_ui/src/theme/app_images.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;

  const AppScaffold({
    required this.title,
    required this.child,
    this.actions,
    this.leading,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: actions,
          leading: leading,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: child,
          ),
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

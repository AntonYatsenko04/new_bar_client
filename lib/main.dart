import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/src/localization/app_localization.dart';
import 'core_ui/src/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDI.initDependencies();

  await EasyLocalization.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = appLocator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.localePath,
      fallbackLocale: AppLocalization.ruLocale,
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp.router(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routerConfig: _appRouter.config(),
            theme: lightTheme,
          );
        },
      ),
    );
  }
}

import 'package:bar_client/core/src/config/app_config.dart';
import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/di/external_dependencies_di.dart';
import 'package:bar_client/service/di/provider_di.dart';
import 'package:bar_client/service/di/service_di.dart';
import 'package:get_it/get_it.dart';

final GetIt appLocator = GetIt.instance;

class AppDI {
  static Future<void> initDependencies() async {
    appLocator
      ..registerSingleton<AppConfig>(
        AppConfig.fromFlavor(Flavor.dev),
      )
      ..registerSingleton<AppLogger>(AppLogger())
      ..registerSingleton<AppRouter>(AppRouter());

    await initExternalDependenciesDi(appLocator);
    initProviderDi(appLocator);
    initServiceDi(appLocator);
  }
}

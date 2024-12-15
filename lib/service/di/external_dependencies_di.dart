import 'dart:async';

import 'package:bar_client/core/src/config/network/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initExternalDependenciesDi(GetIt appLocator) async {
  final Completer<void> sharedPreferencesCompleter = Completer<void>();

  appLocator
    ..registerSingletonAsync<SharedPreferences>(
      () async {
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferencesCompleter.complete();
        return sharedPreferences;
      },
    )
    ..registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: appLocator(),
      ),
    )
    ..registerLazySingleton<Dio>(() => appLocator<DioConfig>().dio);

  return sharedPreferencesCompleter.future;
}

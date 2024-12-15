import 'package:bar_client/service/providers/auth_provider.dart';
import 'package:bar_client/service/providers/broadcast_provider.dart';
import 'package:bar_client/service/providers/local_user_info_provider.dart';
import 'package:bar_client/service/providers/menu_provider.dart';
import 'package:bar_client/service/providers/order_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/providers/table_provider.dart';
import 'package:bar_client/service/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

void initProviderDi(GetIt appLocator) {
  appLocator
    ..registerLazySingleton<SharedPreferencesProvider>(
      () => SharedPreferencesProvider(
        sharedPreferences: appLocator(),
      ),
    )
    ..registerLazySingleton<AuthProvider>(
      () => AuthProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<BroadcastProvider>(
      () => BroadcastProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<MenuProvider>(
      () => MenuProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<OrderProvider>(
      () => OrderProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<UserProvider>(
      () => UserProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<LocalUserInfoProvider>(
      LocalUserInfoProvider.new,
    )
    ..registerLazySingleton<TableProvider>(
      () => TableProvider(
        appLocator<Dio>(),
      ),
    );
}

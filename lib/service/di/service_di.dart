import 'package:bar_client/service/services/auth_service.dart';
import 'package:bar_client/service/services/broadcast_service.dart';
import 'package:bar_client/service/services/menu_service.dart';
import 'package:bar_client/service/services/order_service.dart';
import 'package:bar_client/service/services/table_service.dart';
import 'package:bar_client/service/services/user_service.dart';
import 'package:get_it/get_it.dart';

void initServiceDi(GetIt appLocator) {
  appLocator
    ..registerLazySingleton<AuthService>(
      () => AuthService(
        authProvider: appLocator(),
        sharedPreferencesProvider: appLocator(),
      ),
    )
    ..registerLazySingleton<BroadcastService>(
      () => BroadcastService(
        broadcastProvider: appLocator(),
      ),
    )
    ..registerLazySingleton<MenuService>(
      () => MenuService(
        menuProvider: appLocator(),
        sharedPreferencesProvider: appLocator(),
      ),
    )
    ..registerLazySingleton<OrderService>(
      () => OrderService(
        orderProvider: appLocator(),
        userProvider: appLocator(),
        sharedPreferencesProvider: appLocator(),
      ),
    )
    ..registerLazySingleton<UserService>(
      () => UserService(
        userProvider: appLocator(),
        sharedPreferencesProvider: appLocator(),
        localUserInfoProvider: appLocator(),
      ),
    )
    ..registerLazySingleton<TableService>(
      () => TableService(
        tableProvider: appLocator(),
      ),
    );
}

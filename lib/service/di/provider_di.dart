import 'package:bar_client/service/providers/auth_provider.dart';
import 'package:bar_client/service/providers/bad_broadcast_provider.dart';
import 'package:bar_client/service/providers/broadcast_provider.dart';
import 'package:bar_client/service/providers/cookie_provider.dart';
import 'package:bar_client/service/providers/csrf_token_api_provider.dart';
import 'package:bar_client/service/providers/csrf_token_local_provider.dart';
import 'package:bar_client/service/providers/encryption_provider.dart';
import 'package:bar_client/service/providers/library_provider.dart';
import 'package:bar_client/service/providers/local_user_info_provider.dart';
import 'package:bar_client/service/providers/menu_provider.dart';
import 'package:bar_client/service/providers/order_provider.dart';
import 'package:bar_client/service/providers/session_token_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/providers/table_provider.dart';
import 'package:bar_client/service/providers/user_provider.dart';
import 'package:bar_client/service/providers/weights_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../providers/broadcast_image_provider.dart';

void initProviderDi(GetIt appLocator) {
  appLocator
    ..registerLazySingleton<SharedPreferencesProvider>(
      SessionTokenProvider.new,
    )
    ..registerLazySingleton<AuthProvider>(
      () => AuthProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<BadBroadcastProvider>(
      () => BadBroadcastProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<BroadcastProvider>(
      () => BroadcastProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<BroadcastImageProvider>(
      () => BroadcastImageProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<CookieProvider>(
      CookieProvider.new,
    )
    ..registerLazySingleton<CsrfTokenApiProvider>(
      () => CsrfTokenApiProvider(
        appLocator<Dio>(),
      ),
    )
    ..registerLazySingleton<CsrfTokenLocalProvider>(
      CsrfTokenLocalProvider.new,
    )
    ..registerLazySingleton<EncryptionProvider>(
      EncryptionProvider.new,
    )
    ..registerLazySingleton<LibraryProvider>(
      () => LibraryProvider(
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
    )
    ..registerLazySingleton<WeightsProvider>(
      () => WeightsProvider(
        appLocator<Dio>(),
      ),
    );
}

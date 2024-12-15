import 'package:bar_client/core/src/constants/api_constants.dart';

enum Flavor {
  dev,
}

class AppConfig {
  final Flavor flavor;
  final String baseUrl;

  AppConfig({
    required this.flavor,
    required this.baseUrl,
  });

  factory AppConfig.fromFlavor(Flavor flavor) {
    String baseUrl;

    switch (flavor) {
      case Flavor.dev:
        baseUrl = ApiConstants.baseUrl;
        break;
    }

    return AppConfig(
      flavor: flavor,
      baseUrl: baseUrl,
    );
  }
}

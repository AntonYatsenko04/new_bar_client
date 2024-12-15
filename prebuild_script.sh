flutter clean && flutter pub get
dart run build_runner build -d
dart run easy_localization:generate -f keys -S assets/translations -o locale_keys.g.dart -O lib/core/src/localization/generated

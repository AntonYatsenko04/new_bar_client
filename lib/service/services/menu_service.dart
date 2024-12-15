import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/menu/menu_item_request.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:bar_client/service/models/menu/search_menu_request.dart';
import 'package:bar_client/service/providers/menu_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

class MenuService {
  final MenuProvider _menuProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  MenuService(
      {required MenuProvider menuProvider,
      required SharedPreferencesProvider sharedPreferencesProvider})
      : _menuProvider = menuProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider;

  Future<List<MenuItemResponse>> getAllMenuItems() async {
    return safeRequest<List<MenuItemResponse>>(_menuProvider.getMenuItems);
  }

  Future<void> createMenuItem({required MenuItemRequest menuItem}) async {
    return safeRequest(() => _menuProvider.createMenuItem(menuItem));
  }

  Future<void> updateMenuItem({
    required MenuItemRequest menuItem,
    required int id,
  }) async {
    return safeRequest(() => _menuProvider.updateMenuItem(menuItem, id));
  }

  Future<void> deleteMenuItem({required int id}) async {
    return safeRequest(() => _menuProvider.deleteMenuItem(id));
  }

  Future<List<MenuItemResponse>> searchMenuItems(String searchRequest) async {
    final String? token = _sharedPreferencesProvider.getToken();

    if (token == null) {
      throw AppException(type: AppExceptionType.unAuthorized);
    }

    return safeRequest<List<MenuItemResponse>>(
      () => _menuProvider.searchMenuItems(
        SearchMenuRequest(
          token: token,
          searchRequest: searchRequest,
        ),
      ),
    );
  }
}

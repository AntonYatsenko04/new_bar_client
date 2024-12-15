import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/menu/menu_item_request.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:bar_client/service/services/menu_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_menu_cubit.freezed.dart';
part 'edit_menu_state.dart';

class EditMenuCubit extends Cubit<EditMenuState> {
  final MenuItemResponse? menuItem;
  final AppRouter _appRouter;
  final MenuService _menuService;

  EditMenuCubit({
    required AppRouter appRouter,
    required MenuService menuService,
    this.menuItem,
  })  : _appRouter = appRouter,
        _menuService = menuService,
        super(const EditMenuState());

  Future<void> acceptChanges({
    required String name,
    required String description,
    required String priceText,
  }) async {
    try {
      final int price = int.parse(priceText);
      if (menuItem == null) {
        final MenuItemRequest menuItem = MenuItemRequest(
          name: name,
          description: description,
          price: price,
        );

        await _menuService.createMenuItem(menuItem: menuItem);
      } else {
        await _menuService.updateMenuItem(
          menuItem: MenuItemRequest(
            name: name,
            description: description,
            price: price,
          ),
          id: menuItem!.id,
        );
      }

      await _appRouter.maybePop();
    } on AppException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.errorMessageKey,
        ),
      );
    }
  }
}

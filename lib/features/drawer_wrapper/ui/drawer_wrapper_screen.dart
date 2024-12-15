import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/navigation/app_router/app_router.gr.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/auth/user_model.dart';
import 'package:bar_client/service/services/user_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/src/enums/user_type.dart';

@RoutePage()
class DrawerWrapperScreen extends StatefulWidget {
  const DrawerWrapperScreen({super.key});

  @override
  State<DrawerWrapperScreen> createState() => _DrawerWrapperScreenState();
}

class _DrawerWrapperScreenState extends State<DrawerWrapperScreen> {
  UserType? _userType;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    appLocator<UserService>().getCurrentUserInfo().then(
      (UserModel e) {
        setState(() {
          _userType = e.userType;
        });
      },
      onError: (dynamic e) {
        if (e is AppException) {
          setState(() {
            _errorMessage = e.errorMessageKey.tr();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return AppScaffold(
        title: '',
        child: Center(
          child: ErrorView(message: _errorMessage!),
        ),
      );
    }
    if (_userType != null) {
      final UserType userType = _userType!;

      return AutoTabsScaffold(
        routes: <PageRouteInfo>[
          const BroadcastListRoute(),
          const ListMenuRoute(),
          const ListOrderItemRoute(),
          if (userType == UserType.waiter || userType == UserType.manager) const ListOrderRoute(),
        ],
        bottomNavigationBuilder: (_, TabsRouter tabsRouter) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            showUnselectedLabels: true,
            backgroundColor: Colors.black87,
            unselectedItemColor: Colors.lightBlueAccent,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: LocaleKeys.broadcast_broadcastList.tr(),
                icon: const Icon(Icons.broadcast_on_home_sharp),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.menu_menu.tr(),
                icon: const Icon(Icons.menu_book),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.order_orderItems.tr(),
                icon: const Icon(Icons.fact_check),
              ),
              if (userType == UserType.waiter || userType == UserType.manager)
                BottomNavigationBarItem(
                  label: LocaleKeys.order_orders.tr(),
                  icon: const Icon(Icons.fact_check),
                ),
            ],
          );
        },
      );
    }
    return AppScaffold(
      title: LocaleKeys.order_orders.tr(),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

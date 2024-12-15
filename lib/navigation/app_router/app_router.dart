import 'package:auto_route/auto_route.dart';
import 'package:bar_client/navigation/app_router/app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen|Dialog,Route',
)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          path: '/sign_in',
          page: SignInRoute.page,
        ),
        AutoRoute(
          path: '/sign_up',
          page: SignUpRoute.page,
        ),
        AutoRoute(
          path: '/drawer_wrapper',
          page: DrawerWrapperRoute.page,
          children: <AutoRoute>[
            AutoRoute(
              path: '',
              page: BroadcastListRoute.page,
            ),
            AutoRoute(
              path: 'list_menu',
              page: ListMenuRoute.page,
            ),
            AutoRoute(
              path: 'list_order',
              page: ListOrderRoute.page,
            ),
            AutoRoute(
              path: 'list_order_item',
              page: ListOrderItemRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/add_order_item',
          page: AddOrderItemRoute.page,
        ),
      ];
}

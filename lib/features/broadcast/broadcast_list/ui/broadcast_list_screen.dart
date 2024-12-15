import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/broadcast_list_cubit.dart';
import 'broadcast_list_form.dart';

@RoutePage()
class BroadcastListScreen extends StatelessWidget {
  const BroadcastListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BroadcastListCubit>(
      create: (_) => BroadcastListCubit(
        broadcastService: appLocator(),
        appRouter: appLocator(),
        authService: appLocator(),
      ),
      child: const BroadcastListForm(),
    );
  }
}

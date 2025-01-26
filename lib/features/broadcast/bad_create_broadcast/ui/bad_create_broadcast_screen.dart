import 'package:bar_client/features/broadcast/bad_create_broadcast/cubit/bad_create_broadcast_cubit.dart';
import 'package:bar_client/features/broadcast/bad_create_broadcast/ui/bad_create_broadcast_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/di/app_di.dart';

class BadCreateBroadcastScreen extends StatelessWidget {
  const BadCreateBroadcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BadCreateBroadcastCubit>(
      create: (_) => BadCreateBroadcastCubit(
        broadcastService: appLocator(),
        appRouter: appLocator(),
      ),
      child: const BadCreateBroadcastForm(),
    );
  }
}

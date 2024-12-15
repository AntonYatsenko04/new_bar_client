import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/broadcast/change_broadcast/cubit/change_broadcast_cubit.dart';
import 'package:bar_client/features/broadcast/change_broadcast/ui/change_broadcast_form.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBroadcastScreen extends StatelessWidget {
  final BroadcastModelResponse? broadcastModelResponse;

  const ChangeBroadcastScreen({
    this.broadcastModelResponse,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeBroadcastCubit>(
      create: (_) => ChangeBroadcastCubit(
        appRouter: appLocator(),
        broadcastService: appLocator(),
        broadcast: broadcastModelResponse,
      ),
      child: ChangeBroadcastForm(
        broadcast: broadcastModelResponse,
      ),
    );
  }
}

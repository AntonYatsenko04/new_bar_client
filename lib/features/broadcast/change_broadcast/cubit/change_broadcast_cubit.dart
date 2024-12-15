import 'package:bar_client/core_ui/src/utils/date_formatter.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_request.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:bar_client/service/services/broadcast_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'change_broadcast_state.dart';

class ChangeBroadcastCubit extends Cubit<ChangeBroadcastState> {
  final BroadcastModelResponse? broadcast;
  final BroadcastService _broadcastService;
  final AppRouter _appRouter;

  ChangeBroadcastCubit({
    required AppRouter appRouter,
    required BroadcastService broadcastService,
    this.broadcast,
  })  : _appRouter = appRouter,
        _broadcastService = broadcastService,
        super(ChangeBroadcastState(
            dateTime: broadcast?.dateTime ?? DateTime.now(),),);

  Future<void> acceptChanges({
    required String name,
    required String description,
  }) async {
    final ChangeBroadcastState currentState = state;

    try {
      if (broadcast == null) {
        final BroadcastModelRequest broadcast = BroadcastModelRequest(
          name: name,
          dateTime: state.dateTime,
          description: description,
        );

        await _broadcastService.createBroadcast(
          broadcast: broadcast,
        );
      } else {
        await _broadcastService.updateBroadcast(
          broadcast: BroadcastModelResponse(
            id: broadcast!.id,
            name: name,
            dateTime: state.dateTime,
            description: description,
          ),
        );
      }

      await _appRouter.maybePop();
    } on AppException catch (e) {
      emit(currentState.copyWith(commonError: e.errorMessageKey));
    }
  }

  void setDateTime({DateTime? date, TimeOfDay? time}) {
    DateTime dateTime = date ?? state.dateTime;
    if (time != null) {
      dateTime = dateTime.copyWith(hour: time.hour, minute: time.minute);
    }

    emit(state.copyWith(dateTime: dateTime));
  }
}

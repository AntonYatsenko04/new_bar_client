import 'dart:convert';

import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core_ui/src/utils/date_formatter.dart';
import '../../../../service/exceptions/app_exception.dart';
import '../../../../service/models/broadcast/broadcast_model_request.dart';
import '../../../../service/services/broadcast_service.dart';

part 'bad_create_broadcast_state.dart';

class BadCreateBroadcastCubit extends Cubit<BadCreateBroadcastState> {
  final AppRouter _appRouter;
  final BroadcastService _broadcastService;

  BadCreateBroadcastCubit({
    required AppRouter appRouter,
    required BroadcastService broadcastService,
  })  : _appRouter = appRouter,
        _broadcastService = broadcastService,
        super(BadCreateBroadcastState(dateTime: DateTime.now()));

  Future<void> acceptChanges({
    required String name,
    required String description,
  }) async {
    final BadCreateBroadcastState currentState = state;

    try {
      final BroadcastModelRequest broadcast = BroadcastModelRequest(
        name: name,
        dateTime: state.dateTime,
        description: description,
      );

      print(jsonEncode(broadcast.toJson()));

      await _broadcastService.badCreateBroadcast(
        broadcast: broadcast,
      );

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

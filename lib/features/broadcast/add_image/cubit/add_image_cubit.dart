import 'dart:typed_data';

import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:bar_client/service/services/broadcast_image_service.dart';
import 'package:bar_client/service/services/broadcast_service.dart';
import 'package:bar_client/service/services/file_picker_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../service/exceptions/app_exception.dart';

part 'add_image_cubit.freezed.dart';
part 'add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  final BroadcastService _broadcastService;
  final FilePickerService _filePickerService;
  final BroadcastImageService _broadcastImageService;
  final AppRouter _appRouter;

  AddImageCubit({
    required BroadcastService broadcastService,
    required FilePickerService filePickerService,
    required BroadcastImageService broadcastImageService,
    required AppRouter appRouter,
  })  : _broadcastService = broadcastService,
        _filePickerService = filePickerService,
        _broadcastImageService = broadcastImageService,
        _appRouter = appRouter,
        super(LoadingState());

  Future<void> init() async {
    try {
      final List<BroadcastModelResponse> broadcasts = await _broadcastService.getBroadcasts();
      emit(DataState(broadcasts: broadcasts));
    } on AppException catch (e) {
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  void toggleSaveToSeparateFile() {
    if (state case final DataState state) {
      emit(state.copyWith(saveToSeparateFile: !state.saveToSeparateFile));
    }
  }

  Future<void> pickImage() async {
    if (state case DataState currentState) {
      emit(
        currentState.copyWith(
          commonError: null,
          imageBytes: null,
        ),
      );
      currentState = state as DataState;
      try {
        final Uint8List? imageBytes = await _filePickerService.pickImage();
        emit(currentState.copyWith(imageBytes: imageBytes));
      } on Exception catch (e, st) {
        AppLogger().error(error: e, stackTrace: st);
        emit(currentState.copyWith(commonError: LocaleKeys.broadcast_pleasePickAValidImage));
      }
    }
  }

  void selectBroadcastForUpdate(BroadcastModelResponse? broadcast) {
    if (state case final DataState state) {
      emit(state.copyWith(selectedBroadcast: broadcast));
    }
  }

  Future<void> saveImage() async {
    if (state case DataState currentState) {
      try {
        emit(
          currentState.copyWith(
            blockSendImageButton: true,
          ),
        );

        currentState = state as DataState;

        await _broadcastImageService.uploadBroadcastImage(
          id: currentState.selectedBroadcast!.id,
          image: currentState.imageBytes!,
          toFile: currentState.saveToSeparateFile,
        );

        await _appRouter.maybePop();
      } on AppException catch (e) {
        emit(currentState.copyWith(commonError: e.errorMessageKey));
      } finally {
        if (state case final DataState state) {
          emit(
            state.copyWith(
              blockSendImageButton: false,
            ),
          );
        }
      }
    }
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:bar_client/service/providers/broadcast_image_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';
import 'package:bar_client/service/services/file_picker_service.dart';

import '../models/broadcast/broadcast_image_model.dart';
import '../models/broadcast/broadcast_image_ui_model.dart';

class BroadcastImageService {
  final BroadcastImageProvider _broadcastImageProvider;
  final FilePickerService _filePickerService;

  BroadcastImageService({
    required BroadcastImageProvider broadcastImageProvider,
    required FilePickerService filePickerService,
  })  : _broadcastImageProvider = broadcastImageProvider,
        _filePickerService = filePickerService;

  Future<List<BroadcastImageUiModel>> getBroadcastImages() async {
    final List<BroadcastImageModel> models =
        await safeRequest(_broadcastImageProvider.getBroadcastImages);

    final List<BroadcastImageUiModel> uiModels = [];

    for (final BroadcastImageModel model in models) {
      final Uint8List image = base64Decode(model.image);
      if (await _filePickerService.isValidJpeg(image)) {
        uiModels.add(
          BroadcastImageUiModel(
            broadcastId: model.broadcastId,
            image: image,
          ),
        );
      }
    }

    return uiModels;
  }

  Future<void> uploadBroadcastImage({
    required int id,
    required Uint8List image,
    required bool toFile,
  }) async {
    final String imageString = base64Encode(image);
    final BroadcastImageModel request = BroadcastImageModel(
      image: imageString,
      broadcastId: id,
    );
    return safeRequest(
      toFile
          ? () => _broadcastImageProvider.uploadBroadcastImageToFile(request)
          : () => _broadcastImageProvider.uploadBroadcastImageToDb(request),
    );
  }
}

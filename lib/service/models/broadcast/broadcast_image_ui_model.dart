import 'dart:typed_data';

class BroadcastImageUiModel {
  final int broadcastId;
  final Uint8List image;

  BroadcastImageUiModel({
    required this.broadcastId,
    required this.image,
  });
}

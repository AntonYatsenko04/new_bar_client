import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerService {
  Future<Uint8List?> pickImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['jpg', 'jpeg'],
    );

    final Uint8List? imageBytes = result?.files.firstOrNull?.bytes;
    if (imageBytes != null) {
      final bool isValid = await isValidJpeg(imageBytes);

      return isValid ? imageBytes : null;
    }

    return null;
  }

  Future<bool> isValidJpeg(Uint8List bytes) async {
    try {
      final bool hasCorrectStartBytes =
          bytes.length >= 3 && bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF;

      if (hasCorrectStartBytes) {
        await decodeImageFromList(bytes);
        return true;
      }

      return false;
    } on Exception catch (e) {
      return false;
    }
  }
}

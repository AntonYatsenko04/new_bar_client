import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class EncryptionProvider {
  late final Key _key = Key.fromUtf8(keyString);
  late final IV _iv = IV(Uint8List.fromList([0, 0, 0, 0]));

  final String keyString = 't7LZkjS2t4IO7JyMkVjR/vTN5gYzukIH';

  EncryptionProvider();

  String encryptText(String plainText) {
    final Encrypter encrypter = Encrypter(AES(_key));
    final Encrypted encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decryptText(String encryptedText) {
    final Encrypter encrypter = Encrypter(AES(_key));
    final String decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
    return decrypted;
  }
}

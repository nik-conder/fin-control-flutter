import 'package:encrypt/encrypt.dart';

import 'encryptor.dart';

class AesEncryptor implements Encryptor {
  final Key key;
  final IV iv;

  AesEncryptor({required this.key, required this.iv});

  @override
  String encrypt(String plainText) {
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  @override
  String decrypt(String encryptedText) {
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}

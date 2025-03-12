import '../services/secure_storage.dart';

class TokenRepository {
  final SecureStorage secureStorage;

  TokenRepository(this.secureStorage);

  Future<void> saveToken(String token) async {
    await secureStorage.write('token', token);
  }

  Future<String?> getToken(String value) async {
    return await secureStorage.read(value);
  }

  Future<void> delete(String value) async {
    await secureStorage.delete(value);
  }

  // Future<bool> checkTokenvalid(String value) async {
  //   return
  // }
}

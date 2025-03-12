import '../../data/repository/token_repository.dart';
import '../../data/services/encryptor.dart';

class AuthUseCase {
  final TokenRepository _tokenRepository;
  final Encryptor encryptor;
  AuthUseCase(this._tokenRepository, this.encryptor);

  Future<void> saveToken(String token) async {
    //final encrypt = encryptor.encrypt(token);
    //await _tokenRepository.saveToken(encrypt);
    await _tokenRepository.saveToken(token);
  }

  Future<String?> getToken(String value) async {
    final token = await _tokenRepository.getToken('token');
    //return (token != null) ? encryptor.decrypt(token) : null;
    return token;
  }

  Future<void> deleteToken() async {
    await _tokenRepository.delete('token');
  }
}

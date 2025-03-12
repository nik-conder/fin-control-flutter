import 'package:dio/dio.dart';

import '../models/account_dto.dart';

class UsersService {
  final Dio _dio;

  UsersService(this._dio);

  Future<List<AccountDto>> fetchAccounts() async {
    try {
      final response = await _dio.post(
        'tinkoff.public.invest.api.contract.v1.UsersService/GetAccounts',
        data: {},
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final accounts = response.data['accounts'] as List<dynamic>;
      return accounts.map((json) => AccountDto.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? e.message;
        throw Exception(
            'Ошибка загрузки счетов: $errorMessage (код: ${e.response?.statusCode})');
      } else {
        throw Exception('Ошибка сети: ${e.message}');
      }
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }
}

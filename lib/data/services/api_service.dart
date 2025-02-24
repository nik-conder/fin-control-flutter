// lib/data/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = 'https://sandbox-invest-public-api.tinkoff.ru/rest/';
    _dio.options.headers['Authorization'] = 't.hk571jExcB1tYv2Yeh3J1NuToj1Oq89fs1mN0fp03vaXrSn8LGgzFFMw8IwLPsQ4w2Y6XyHPhz6kEqr9VzKkwg';
  }

  Future<List<dynamic>> fetchTransactions({
    required String from,
    required String to,
    int limit = 50,
  }) async {
    final response = await _dio.get(
      '/transactions',
      queryParameters: {
        'from': from,
        'to': to,
        'limit': limit,
      },
    );
    return response.data['transactions']; // Предполагаем, что API возвращает JSON с ключом "transactions"
  }
}
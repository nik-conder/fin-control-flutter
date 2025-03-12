import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  final String _token;

  ApiClient(this._token) : _dio = Dio() {
    _dio.options.baseUrl = 'https://sandbox-invest-public-api.tinkoff.ru/rest/';
    _dio.options.headers['Authorization'] = 'Bearer $_token';
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (msg) => print(msg),
    ));
  }

  Dio get dio => _dio;
}

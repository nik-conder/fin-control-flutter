import 'package:dio/dio.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio();
    final String _token =
        't.hk571jExcB1tYv2Yeh3J1NuToj1Oq89fs1mN0fp03vaXrSn8LGgzFFMw8IwLPsQ4w2Y6XyHPhz6kEqr9VzKkwg';
    dio.options.baseUrl = 'https://sandbox-invest-public-api.tinkoff.ru/rest/';

    dio.options.headers['Authorization'] = 'Bearer $_token';
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (msg) => print(msg),
    ));
    return dio;
  }
}

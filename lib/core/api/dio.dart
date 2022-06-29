import 'package:dio/dio.dart';

Dio getDio() {
  final Dio dio = Dio();
  dio.options.connectTimeout = 20000;
  dio.options.sendTimeout = 20000;
  dio.options.receiveTimeout = 20000;
  dio.options.baseUrl = 'http://numbersapi.com/';

  return dio;
}

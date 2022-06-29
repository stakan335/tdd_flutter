import 'package:dio/dio.dart';

abstract class NumberTriviaService {
  Future<Response> getRandomTrivia();

  Future<Response> getConcreteNumberTrivia(int number);
}

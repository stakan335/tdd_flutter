import 'package:dio/dio.dart';
import 'package:test_project/core/api/interfaces/number_trivia_service.dart';

class NumberTriviaServiceImpl implements NumberTriviaService {
  const NumberTriviaServiceImpl(this.dio);

  final Dio dio;

  @override
  Future<Response> getRandomTrivia() => _getNumberTrivia('random');

  @override
  Future<Response> getConcreteNumberTrivia(int number) =>
      _getNumberTrivia('$number');

  Future<Response> _getNumberTrivia(String url) async {
    final response = await dio.get(
      url,
    );

    return response;
  }
}

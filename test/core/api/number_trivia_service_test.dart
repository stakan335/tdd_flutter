import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:test_project/core/api/number_trivia_service_impl.dart';

import '../../responses/number_trivia_responses.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio _dio;
  late NumberTriviaServiceImpl _service;
  const tNumber = 1;

  setUp(() {
    _dio = MockDio();
    _service = NumberTriviaServiceImpl(_dio);
  });

  group('getConcreteNumberTrivia', () {
    test(
      'should call dio with tNumber',
      () async {
        //arrange
        when(() => _dio.get(any())).thenAnswer(successAnswer);

        //act
        await _service.getConcreteNumberTrivia(tNumber);

        //assert
        verify(() => _dio.get('$tNumber'));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    test(
      'should call dio with random',
      () async {
        //arrange
        when(() => _dio.get(any())).thenAnswer(successAnswer);

        //act
        await _service.getRandomTrivia();

        //assert
        verify(() => _dio.get('random'));
      },
    );
  });
}

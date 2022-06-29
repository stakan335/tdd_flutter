import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_project/core/api/interfaces/number_trivia_service.dart';
import 'package:test_project/core/error/exceptions.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDS {
  ///Calls the http://numbersapi.com/{number} endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///Calls the http://numbersapi.com/random endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandonNumberTrivia();
}

class NumberTriviaRemoteDSImpl implements NumberTriviaRemoteDS {
  const NumberTriviaRemoteDSImpl(this.numberTriviaService);

  final NumberTriviaService numberTriviaService;

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTrivia(numberTriviaService.getConcreteNumberTrivia(number));

  @override
  Future<NumberTriviaModel> getRandonNumberTrivia() =>
      _getTrivia(numberTriviaService.getRandomTrivia());

  Future<NumberTriviaModel> _getTrivia(
    Future<Response<dynamic>> getTriviaFromService,
  ) async {
    final response = await getTriviaFromService;
    if (response.statusCode == HttpStatus.ok) {
      return NumberTriviaModel(
        text: response.data,
        number: int.parse(response.data.split(' ').first),
      );
    }

    throw ServerException();
  }
}

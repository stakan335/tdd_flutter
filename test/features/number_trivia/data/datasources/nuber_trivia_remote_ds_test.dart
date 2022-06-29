import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_project/core/api/interfaces/number_trivia_service.dart';
import 'package:test_project/core/error/exceptions.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_remote_ds.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../responses/number_trivia_responses.dart';

class MockNumberTriviaService extends Mock implements NumberTriviaService {}

void main() {
  late NumberTriviaRemoteDSImpl _remoteDS;
  late MockNumberTriviaService _mockNumberTriviaService;

  const _tNumber = 1;
  final _tNumberTriviaModel = NumberTriviaModel.fromJson(
    jsonDecode(
      fixtureJson('trivia'),
    ),
  );

  setUp(() {
    _mockNumberTriviaService = MockNumberTriviaService();
    _remoteDS = NumberTriviaRemoteDSImpl(_mockNumberTriviaService);
  });

  void setUpMockServiceGetConcreteNumberTriviaSuccess() {
    when(() => _mockNumberTriviaService.getConcreteNumberTrivia(any()))
        .thenAnswer(successAnswer);
  }

  void setUpMockServiceGetRandomNumberTriviaSuccess() {
    when(() => _mockNumberTriviaService.getRandomTrivia())
        .thenAnswer(successAnswer);
  }

  void setUpMockServiceGetConcreteNumberTriviaFailure() {
    when(() => _mockNumberTriviaService.getConcreteNumberTrivia(any()))
        .thenAnswer(failureAnswer);
  }

  void setUpMockServiceGetRandomNumberTriviaFailure() {
    when(() => _mockNumberTriviaService.getRandomTrivia())
        .thenAnswer(failureAnswer);
  }

  group('getConcreteNumberTrivia', () {
    test(
      'should call getConcreteNumberTrivia from MockNumberTriviaService with number',
      () async {
        //arrange
        setUpMockServiceGetConcreteNumberTriviaSuccess();

        //act
        await _remoteDS.getConcreteNumberTrivia(_tNumber);

        //assert
        verify(
            () => _mockNumberTriviaService.getConcreteNumberTrivia(_tNumber));
      },
    );

    test(
      'should return NumberTrivia when reponse status code is 200 (success)',
      () async {
        //arrange
        setUpMockServiceGetConcreteNumberTriviaSuccess();

        //act
        final result = await _remoteDS.getConcreteNumberTrivia(_tNumber);

        //assert
        expect(result, _tNumberTriviaModel);
      },
    );

    test(
      'should throw ServerException when response status code is not 200',
      () async {
        //arrange
        setUpMockServiceGetConcreteNumberTriviaFailure();

        //act
        final result = _remoteDS.getConcreteNumberTrivia;

        //assert
        expect(() => result(_tNumber),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group(
    'getRandomNumberTrivia',
    () {
      test(
        'should call getConcreteNumberTrivia from MockNumberTriviaService with number',
        () async {
          //arrange
          setUpMockServiceGetRandomNumberTriviaSuccess();

          //act
          await _remoteDS.getRandonNumberTrivia();

          //assert
          verify(() => _mockNumberTriviaService.getRandomTrivia());
        },
      );

      test(
        'should return NumberTrivia when reponse status code is 200 (success)',
        () async {
          //arrange
          setUpMockServiceGetRandomNumberTriviaSuccess();

          //act
          final result = await _remoteDS.getRandonNumberTrivia();

          //assert
          expect(result, _tNumberTriviaModel);
        },
      );

      test(
        'should throw ServerException when response status code is not 200',
        () async {
          //arrange
          setUpMockServiceGetRandomNumberTriviaFailure();

          //act
          final result = _remoteDS.getRandonNumberTrivia;

          //assert
          expect(() => result(), throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );
}

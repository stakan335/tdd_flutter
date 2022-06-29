import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/core/error/failures.dart';
import 'package:test_project/core/usecases/usecase.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:test_project/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:test_project/generated/l10n.dart';

class MockGetConcreteNumberTriviaUC extends Mock
    implements GetConcreteNumberTriviaUC {}

class MockGetRandomNumberTriviaUC extends Mock
    implements GetRandomNumberTriviaUC {}

class FakeGetConcreteNumberTriviaParams extends Fake
    implements GetConcreteNumberTriviaParams {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  S.load(const Locale('en'));
  late NumberTriviaBloc _bloc;

  late MockGetConcreteNumberTriviaUC _mockGetConcreteNumberTriviaUC;
  late MockGetRandomNumberTriviaUC _mockGetRandomNumberTriviaUC;

  setUpAll(() {
    registerFallbackValue(FakeGetConcreteNumberTriviaParams());
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    _mockGetConcreteNumberTriviaUC = MockGetConcreteNumberTriviaUC();
    _mockGetRandomNumberTriviaUC = MockGetRandomNumberTriviaUC();

    _bloc = NumberTriviaBloc(
      getConcreteNumberTriviaUC: _mockGetConcreteNumberTriviaUC,
      getRandomNumberTriviaUC: _mockGetRandomNumberTriviaUC,
    );
  });

  group('getConcreteNumberTrivia', () {
    const _tNumberInvalidString = 'abc';
    const _tNumberValidString = '1';
    const _tNumberParsed = 1;
    const _tNumberTrivia = NumberTrivia(
      number: 1,
      text: 'test text',
    );

    void setUpGetConcreteFailure() =>
        when(() => _mockGetConcreteNumberTriviaUC(any()))
            .thenAnswer((invocation) async => const Left(ServerFailure()));

    void setUpGetConcreteSuccess() =>
        when(() => _mockGetConcreteNumberTriviaUC(any()))
            .thenAnswer((invocation) async => const Right(_tNumberTrivia));

    test(
      'should emit NumberTriviaError state when input is invalid',
      () async {
        //act
        _bloc.add(const GetTriviaForConcrete(_tNumberInvalidString));
        //assert
        final _expected = [
          NumberTriviaError(S.current.invalidInputFailureMsg),
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );

    test(
      'should get data from the concrete UC',
      () async {
        //arrange
        setUpGetConcreteSuccess();

        //act
        _bloc.add(const GetTriviaForConcrete(_tNumberValidString));
        await untilCalled(() => _mockGetConcreteNumberTriviaUC(any()));

        //assert
        verify(
          () => _mockGetConcreteNumberTriviaUC(
            const GetConcreteNumberTriviaParams(_tNumberParsed),
          ),
        );
      },
    );

    test(
      'should emit [NumberTriviaLoading, NumberTriviaLoaded] when data is gotten successfully',
      () async {
        //arrange
        setUpGetConcreteSuccess();

        //act
        _bloc.add(const GetTriviaForConcrete(_tNumberValidString));

        //assert
        final _expected = [
          NumberTriviaLoading(),
          const NumberTriviaLoaded(_tNumberTrivia)
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );

    test(
      'should emit [NumberTriviaLoading, NumberTriviaError] when data is gotten successfully',
      () async {
        //arrange
        setUpGetConcreteFailure();

        //act
        _bloc.add(const GetTriviaForConcrete(_tNumberValidString));

        //assert
        final _expected = [
          NumberTriviaLoading(),
          NumberTriviaError(S.current.serverFailureMsg),
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );

    test(
      'should emit [NumberTriviaLoading, NumberTriviaError] when a proper message of the error when getting data fails',
      () async {
        //arrange
        when(() => _mockGetConcreteNumberTriviaUC(any()))
            .thenAnswer((invocation) async => const Left(CacheFailure()));

        //act
        _bloc.add(const GetTriviaForConcrete(_tNumberValidString));

        //assert
        final _expected = [
          NumberTriviaLoading(),
          NumberTriviaError(S.current.cacheFailureMsg),
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );
  });

  group('getRandomNumberTrivia', () {
    const _tNumberValidString = '1';

    const _tNumberTrivia = NumberTrivia(
      number: 1,
      text: 'test text',
    );

    void setUpGetRandomFailure() =>
        when(() => _mockGetRandomNumberTriviaUC(any()))
            .thenAnswer((invocation) async => const Left(ServerFailure()));

    void setUpGetRandomSuccess() =>
        when(() => _mockGetRandomNumberTriviaUC(any()))
            .thenAnswer((invocation) async => const Right(_tNumberTrivia));

    test(
      'should get data from the random UC',
      () async {
        //arrange
        setUpGetRandomSuccess();

        //act
        _bloc.add(const GetTriviaForRandom());
        await untilCalled(() => _mockGetRandomNumberTriviaUC(any()));

        //assert
        verify(() => _mockGetRandomNumberTriviaUC(NoParams()));
      },
    );

    test(
      'should emit [NumberTriviaLoading, NumberTriviaLoaded] when data is gotten successfully',
      () async {
        //arrange
        setUpGetRandomSuccess();

        //act
        _bloc.add(const GetTriviaForRandom());

        //assert
        final _expected = [
          NumberTriviaLoading(),
          const NumberTriviaLoaded(_tNumberTrivia)
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );

    test(
      'should emit [NumberTriviaLoading, NumberTriviaError] when data is gotten successfully',
      () async {
        //arrange
        setUpGetRandomFailure();

        //act
        _bloc.add(const GetTriviaForRandom());

        //assert
        final _expected = [
          NumberTriviaLoading(),
          NumberTriviaError(S.current.serverFailureMsg),
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );

    test(
      'should emit [NumberTriviaLoading, NumberTriviaError] when a proper message of the error when getting data fails',
      () async {
        //arrange
        when(() => _mockGetRandomNumberTriviaUC(any()))
            .thenAnswer((invocation) async => const Left(CacheFailure()));

        //act
        _bloc.add(const GetTriviaForRandom());

        //assert
        final _expected = [
          NumberTriviaLoading(),
          NumberTriviaError(S.current.cacheFailureMsg),
        ];

        await expectLater(
          _bloc.stream,
          emitsInOrder(_expected),
        );
      },
    );
  });
}

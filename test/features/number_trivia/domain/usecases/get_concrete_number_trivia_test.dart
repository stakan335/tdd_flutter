import 'package:dartz/dartz.dart';

import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTiviaRepo extends Mock implements NumberTriviaRepo {}

void main() {
  late GetConcreteNumberTriviaUC _usecase;
  late MockNumberTiviaRepo _mockNumberTiviaRepo;

  setUp(() {
    _mockNumberTiviaRepo = MockNumberTiviaRepo();
    _usecase = GetConcreteNumberTriviaUC(_mockNumberTiviaRepo);
  });

  const _tNumber = 1;
  const _tNumberTrivia = NumberTrivia(number: _tNumber, text: 'Some text');

  test(
    'should get trivia for the number from the repo',
    () async {
      //arrange
      when(
        () => _mockNumberTiviaRepo.getConcreteNumberTrivia(
          any(that: isNotNull),
        ),
      ).thenAnswer((realInvocation) async => const Right(_tNumberTrivia));

      //act
      final result =
          await _usecase(const GetConcreteNumberTriviaParams(_tNumber));

      //assert
      expect(result, const Right(_tNumberTrivia));
      verify(() => _mockNumberTiviaRepo.getConcreteNumberTrivia(_tNumber));
      verifyNoMoreInteractions(_mockNumberTiviaRepo);
    },
  );
}

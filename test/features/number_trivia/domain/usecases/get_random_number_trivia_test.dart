import 'package:dartz/dartz.dart';
import 'package:test_project/core/usecases/usecase.dart';

import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTiviaRepo extends Mock implements NumberTriviaRepo {}

void main() {
  late GetRandomNumberTriviaUC _usecase;
  late MockNumberTiviaRepo _mockNumberTiviaRepo;

  setUp(() {
    _mockNumberTiviaRepo = MockNumberTiviaRepo();
    _usecase = GetRandomNumberTriviaUC(_mockNumberTiviaRepo);
  });

  const tNumberTrivia = NumberTrivia(number: 1, text: 'Some text');

  test(
    'should get trivia from the repo',
    () async {
      //arrange
      when(
        () => _mockNumberTiviaRepo.getRandonNumberTrivia(),
      ).thenAnswer((realInvocation) async => const Right(tNumberTrivia));

      //act
      final result = await _usecase(NoParams());

      //assert
      expect(result, const Right(tNumberTrivia));
      verify(() => _mockNumberTiviaRepo.getRandonNumberTrivia());
      verifyNoMoreInteractions(_mockNumberTiviaRepo);
    },
  );
}

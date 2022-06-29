import 'package:dartz/dartz.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

class GetRandomNumberTriviaUC implements UseCase<NumberTrivia, NoParams> {
  const GetRandomNumberTriviaUC(this.repo);

  final NumberTriviaRepo repo;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repo.getRandonNumberTrivia();
  }
}

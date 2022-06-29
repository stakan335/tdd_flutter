import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';

class GetConcreteNumberTriviaUC
    implements UseCase<NumberTrivia, GetConcreteNumberTriviaParams> {
  const GetConcreteNumberTriviaUC(this.repo);

  final NumberTriviaRepo repo;

  @override
  Future<Either<Failure, NumberTrivia>> call(
      GetConcreteNumberTriviaParams params) async {
    return await repo.getConcreteNumberTrivia(params.number);
  }
}

class GetConcreteNumberTriviaParams extends Equatable {
  const GetConcreteNumberTriviaParams(this.number);

  final int number;

  @override
  List<Object?> get props => [number];
}

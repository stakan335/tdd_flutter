part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaLoaded extends NumberTriviaState {
  const NumberTriviaLoaded(this.trivia);

  final NumberTrivia trivia;

  @override
  List<Object> get props => [trivia];
}

class NumberTriviaError extends NumberTriviaState {
  const NumberTriviaError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

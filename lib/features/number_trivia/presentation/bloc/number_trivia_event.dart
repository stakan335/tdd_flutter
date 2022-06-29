part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcrete extends NumberTriviaEvent {
  const GetTriviaForConcrete(this.numberString);

  final String numberString;

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandom extends NumberTriviaEvent {
  const GetTriviaForRandom();
}

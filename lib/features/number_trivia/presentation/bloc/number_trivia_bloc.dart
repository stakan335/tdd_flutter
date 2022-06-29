import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/core/error/failures.dart';
import 'package:test_project/core/usecases/usecase.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:test_project/core/extensions/string_ext.dart';
import 'package:test_project/generated/l10n.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    required this.getConcreteNumberTriviaUC,
    required this.getRandomNumberTriviaUC,
  }) : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcrete) {
        final input = event.numberString.toUnsignedInt();

        await input.fold(
          (failure) async =>
              emit(NumberTriviaError(S.current.invalidInputFailureMsg)),
          (number) async {
            emit(NumberTriviaLoading());

            final failureOrTrivia = await getConcreteNumberTriviaUC(
                GetConcreteNumberTriviaParams(number));

            _emitLoadedOrErrorState(failureOrTrivia, emit);
          },
        );
        return;
      }
      if (event is GetTriviaForRandom) {
        emit(NumberTriviaLoading());

        final failureOrTrivia = await getRandomNumberTriviaUC(NoParams());

        _emitLoadedOrErrorState(failureOrTrivia, emit);

        return;
      }
    });
  }

  void _emitLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia,
      Emitter<NumberTriviaState> emit) {
    failureOrTrivia.fold(
      (failure) => emit(NumberTriviaError(failure.msg)),
      (trivia) => emit(NumberTriviaLoaded(trivia)),
    );
  }

  final GetConcreteNumberTriviaUC getConcreteNumberTriviaUC;
  final GetRandomNumberTriviaUC getRandomNumberTriviaUC;
}

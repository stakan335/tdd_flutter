import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:test_project/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:test_project/generated/l10n.dart';
import 'package:test_project/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.numberTrivai)),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => sl<NumberTriviaBloc>(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (_, state) {
                    if (state is NumberTriviaInitial) {
                      return const MesageDisplay(msg: 'Start searching');
                    }
                    if (state is NumberTriviaError) {
                      return MesageDisplay(msg: state.errorMessage);
                    }
                    if (state is NumberTriviaLoaded) {
                      return TriviaDisplay(trivia: state.trivia);
                    }
                    if (state is NumberTriviaLoading) {
                      return const LoadingWidget();
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                const TriviaControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

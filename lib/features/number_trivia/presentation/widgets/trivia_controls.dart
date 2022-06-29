part of 'widgets.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  String inputString = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input  a number',
          ),
          onChanged: (value) {
            inputString = value;
          },
          onSubmitted: (value) {
            getConcrete();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: getConcrete,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Text('Search'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: getRandom,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void getConcrete() {
    _controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForConcrete(inputString),
    );
  }

  void getRandom() {
    _controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(const GetTriviaForRandom());
  }
}

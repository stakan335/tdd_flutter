part of 'widgets.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    required this.trivia,
    Key? key,
  }) : super(key: key);

  final NumberTrivia trivia;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AutoSizeText(
                trivia.number.toString(),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                trivia.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

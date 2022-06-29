part of 'widgets.dart';

class MesageDisplay extends StatelessWidget {
  const MesageDisplay({
    required this.msg,
    Key? key,
  }) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}

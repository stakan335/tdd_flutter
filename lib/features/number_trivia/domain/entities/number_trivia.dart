import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  const NumberTrivia({
    required this.number,
    required this.text,
  });

  final String text;
  final int number;

  @override
  List<Object?> get props => [
        text,
        number,
      ];
}


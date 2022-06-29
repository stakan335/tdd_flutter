import 'package:json_annotation/json_annotation.dart';
import 'package:test_project/core/extensions/int_ext.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required String text, required this.number})
      : super(
          number: number,
          text: text,
        );

  factory NumberTriviaModel.fromJson(dynamic json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);

  @JsonKey(fromJson: IntExt.fromJson)
  @override
  final int number;
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_keys.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const _tNumberTriviaModel = NumberTriviaModel(
    number: 1,
    text: 'Some text',
  );

  test(
    'should be a subclass of NumberTrivia entitie',
    () async {
      //assert
      expect(_tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixtureJson(FixtureKey.trivia),
        );
        //act
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert
        expect(result, _tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is regarded as a double',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixtureJson(FixtureKey.triviaDouble),
        );
        //act
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert
        expect(result, _tNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containgn the proper data',
      () async {
        //act
        final result = _tNumberTriviaModel.toJson();

        //assert
        final expectedMap = {
          'text': 'Some text',
          'number': 1,
        };

        expect(result, expectedMap);
      },
    );
  });
}

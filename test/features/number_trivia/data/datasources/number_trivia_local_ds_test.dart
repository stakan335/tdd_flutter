import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/error/exceptions.dart';
import 'package:test_project/core/keys/shared_preferences_keys.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_local_ds.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_keys.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDSImpl _localDS;
  late MockSharedPreferences _mockSharedPreferences;

  setUp(() {
    _mockSharedPreferences = MockSharedPreferences();
    _localDS = NumberTriviaLocalDSImpl(_mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTrivaiModel = NumberTriviaModel.fromJson(
        json.decode(fixtureJson(FixtureKey.triviaCached)));
    test(
      'should return NumberTriviaModel from shared preferences when there is one in the cache',
      () async {
        //arrange
        when(() => _mockSharedPreferences.getString(any(that: isNotNull)))
            .thenReturn(fixtureJson(FixtureKey.triviaCached));

        //act
        final result = await _localDS.getLastNumberTrivia();

        //assert
        verify(() => _mockSharedPreferences
            .getString(SharedPrefKeys.cahcedNumberTrivia));

        expect(result, tNumberTrivaiModel);
      },
    );

    test(
      'should throw CacheException  when there is not a cached value',
      () async {
        //arrange
        when(() => _mockSharedPreferences.getString(any(that: isNotNull)))
            .thenReturn(null);

        //act
        final call = _localDS.getLastNumberTrivia;

        //assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cachedNumberTrivia', () {
    const tNumberTrivaiModel = NumberTriviaModel(number: 1, text: 'Some text');

    test(
      'should call SharedPreferences to cache the data',
      () async {
        //arrange
        when(() => _mockSharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);

        //act
        await _localDS.cacheNumberTrivia(tNumberTrivaiModel);

        //assert
        final expectedJsonString = json.encode(tNumberTrivaiModel.toJson());
        verify(() => _mockSharedPreferences.setString(
            SharedPrefKeys.cahcedNumberTrivia, expectedJsonString));
      },
    );
  });
}

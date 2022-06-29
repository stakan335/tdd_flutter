import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/error/exceptions.dart';
import 'package:test_project/core/keys/shared_preferences_keys.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDS {
  ///Gets the cached [NumberTriviaModel] which was gotted the last time
  ///the user had an internet connection.
  ///
  ///Throws [CacheException] if no cached data in present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  ///Cache [NumberTriviaModel]
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDSImpl implements NumberTriviaLocalDS {
  const NumberTriviaLocalDSImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    final jsonToCache = json.encode(triviaToCache.toJson());
    return sharedPreferences.setString(
      SharedPrefKeys.cahcedNumberTrivia,
      jsonToCache,
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString =
        sharedPreferences.getString(SharedPrefKeys.cahcedNumberTrivia);

    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }

    throw CacheException();
  }
}

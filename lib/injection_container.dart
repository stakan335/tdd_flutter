import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/api/interfaces/number_trivia_service.dart';
import 'package:test_project/core/api/number_trivia_service_impl.dart';
import 'package:test_project/core/injections/number_trivia_injection.dart';
import 'package:test_project/core/network/network_info.dart';

import 'core/api/dio.dart';

//Init service locator
final sl = GetIt.instance;

Future<void> init() async {
  initFeatures();
  await initCore();
  initServices();
}

void initFeatures() {
  initNumberTriviaFeature();
}

void initServices() {
  sl.registerLazySingleton<NumberTriviaService>(
      () => NumberTriviaServiceImpl(sl()));
}

Future<void> initCore() async {
  sl.registerLazySingleton<NetwokInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<Dio>(() => getDio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
}

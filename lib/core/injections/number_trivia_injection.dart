import 'package:test_project/features/number_trivia/data/datasources/number_trivia_local_ds.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_remote_ds.dart';
import 'package:test_project/features/number_trivia/data/repo/number_trivia_repo_impl.dart';
import 'package:test_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:test_project/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:test_project/injection_container.dart';

void initNumberTriviaFeature() {
//Bloc
  sl.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      getConcreteNumberTriviaUC: sl(),
      getRandomNumberTriviaUC: sl(),
    ),
  );

  //Usecases
  sl.registerLazySingleton<GetConcreteNumberTriviaUC>(
      () => GetConcreteNumberTriviaUC(sl()));
  sl.registerLazySingleton<GetRandomNumberTriviaUC>(
      () => GetRandomNumberTriviaUC(sl()));

  //Repo
  sl.registerLazySingleton<NumberTriviaRepo>(
    () => NumberTriviaRepoImpl(
      remoteDS: sl(),
      localDS: sl(),
      netwokInfo: sl(),
    ),
  );

  //Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDS>(
    () => NumberTriviaRemoteDSImpl(sl()),
  );
  sl.registerLazySingleton<NumberTriviaLocalDS>(
    () => NumberTriviaLocalDSImpl(sl()),
  );
}

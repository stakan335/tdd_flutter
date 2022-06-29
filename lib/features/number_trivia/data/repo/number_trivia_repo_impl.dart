import 'package:dartz/dartz.dart';
import 'package:test_project/core/error/exceptions.dart';
import 'package:test_project/core/network/network_info.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_local_ds.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_remote_ds.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import '/core/error/failures.dart';

typedef ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepoImpl implements NumberTriviaRepo {
  NumberTriviaRepoImpl({
    required this.remoteDS,
    required this.localDS,
    required this.netwokInfo,
  });

  final NumberTriviaRemoteDS remoteDS;
  final NumberTriviaLocalDS localDS;
  final NetwokInfo netwokInfo;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getNumberTrivia(() {
      return remoteDS.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandonNumberTrivia() async {
    return await _getNumberTrivia(() {
      return remoteDS.getRandonNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(
    ConcreteOrRandomChooser getTrivia,
  ) async {
    final isConnected = await netwokInfo.isConnected;
    if (isConnected) {
      try {
        final remoteTrivia = await getTrivia();
        await localDS.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDS.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }
}

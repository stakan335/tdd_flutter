import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/core/error/exceptions.dart';
import 'package:test_project/core/error/failures.dart';
import 'package:test_project/core/network/network_info.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_local_ds.dart';
import 'package:test_project/features/number_trivia/data/datasources/number_trivia_remote_ds.dart';
import 'package:test_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_project/features/number_trivia/data/repo/number_trivia_repo_impl.dart';
import 'package:test_project/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDS extends Mock implements NumberTriviaRemoteDS {}

class MockLocalDS extends Mock implements NumberTriviaLocalDS {}

class MockNetworkInfo extends Mock implements NetwokInfo {}

void main() {
  late NumberTriviaRepoImpl _repo;
  late MockRemoteDS _mockRemoteDS;
  late MockLocalDS _mockLocalDS;
  late MockNetworkInfo _mockNetworkInfo;

  setUp(() {
    _mockRemoteDS = MockRemoteDS();
    _mockLocalDS = MockLocalDS();
    _mockNetworkInfo = MockNetworkInfo();
    _repo = NumberTriviaRepoImpl(
      remoteDS: _mockRemoteDS,
      localDS: _mockLocalDS,
      netwokInfo: _mockNetworkInfo,
    );
  });

  const _tNumber = 1;
  const _tNumberTriviaModel = NumberTriviaModel(
    number: _tNumber,
    text: 'Some text',
  );
  const NumberTrivia _tNumberTrivia = _tNumberTriviaModel;

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => _mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => _mockLocalDS.cacheNumberTrivia(_tNumberTriviaModel))
            .thenAnswer((invocation) async => () {});
      });

      body();
    });
  }

  void runTestsOfline(Function body) {
    group('device is ofline', () {
      setUp(() {
        when(() => _mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(() => _mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => _mockRemoteDS.getConcreteNumberTrivia(any(that: isNotNull)))
            .thenAnswer((_) async => _tNumberTriviaModel);

        when(() => _mockLocalDS.cacheNumberTrivia(_tNumberTriviaModel))
            .thenAnswer((invocation) async => () {});
        //act
        await _repo.getConcreteNumberTrivia(_tNumber);
        //assert
        verify(() => _mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote DS is successfull',
        () async {
          //arrange
          when(() =>
                  _mockRemoteDS.getConcreteNumberTrivia(any(that: isNotNull)))
              .thenAnswer((_) async => _tNumberTriviaModel);

          //act
          final result = await _repo.getConcreteNumberTrivia(_tNumber);

          //assert
          verify(() => _mockRemoteDS.getConcreteNumberTrivia(_tNumber));
          expect(result, const Right(_tNumberTrivia));
        },
      );

      test(
        'should cache the data localy when the call to remote DS is successfull',
        () async {
          //arrange
          when(() =>
                  _mockRemoteDS.getConcreteNumberTrivia(any(that: isNotNull)))
              .thenAnswer((_) async => _tNumberTriviaModel);

          //act
          await _repo.getConcreteNumberTrivia(_tNumber);

          //assert
          verify(() => _mockRemoteDS.getConcreteNumberTrivia(_tNumber));
          verify(() => _mockLocalDS.cacheNumberTrivia(_tNumberTriviaModel));
        },
      );

      test(
        'should return ServerFailure when the call to remote DS is unsuccessfull',
        () async {
          //arrange
          when(() =>
                  _mockRemoteDS.getConcreteNumberTrivia(any(that: isNotNull)))
              .thenThrow(ServerException());

          //act
          final result = await _repo.getConcreteNumberTrivia(_tNumber);

          //assert
          verify(() => _mockRemoteDS.getConcreteNumberTrivia(_tNumber));
          verifyZeroInteractions(_mockLocalDS);
          expect(result, const Left(ServerFailure()));
        },
      );
    });

    runTestsOfline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          //arrange
          when(() => _mockLocalDS.getLastNumberTrivia())
              .thenAnswer((invocation) async => _tNumberTriviaModel);

          //act
          final result = await _repo.getConcreteNumberTrivia(_tNumber);

          //assert
          verifyZeroInteractions(_mockRemoteDS);
          verify(() => _mockLocalDS.getLastNumberTrivia());
          expect(result, const Right(_tNumberTrivia));
        },
      );

      test(
        'should return CacheFailure when there is no cached data is present',
        () async {
          //arrange
          when(() => _mockLocalDS.getLastNumberTrivia())
              .thenThrow(CacheException());

          //act
          final result = await _repo.getConcreteNumberTrivia(_tNumber);

          //assert
          verifyZeroInteractions(_mockRemoteDS);
          verify(() => _mockLocalDS.getLastNumberTrivia());
          expect(result, const Left(CacheFailure()));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(() => _mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => _mockRemoteDS.getRandonNumberTrivia())
            .thenAnswer((_) async => _tNumberTriviaModel);

        when(() => _mockLocalDS.cacheNumberTrivia(_tNumberTriviaModel))
            .thenAnswer((invocation) async => () {});
        //act
        await _repo.getRandonNumberTrivia();
        //assert
        verify(() => _mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote DS is successfull',
        () async {
          //arrange
          when(() => _mockRemoteDS.getRandonNumberTrivia())
              .thenAnswer((_) async => _tNumberTriviaModel);

          //act
          final result = await _repo.getRandonNumberTrivia();

          //assert
          verify(() => _mockRemoteDS.getRandonNumberTrivia());
          expect(result, const Right(_tNumberTrivia));
        },
      );

      test(
        'should cache the data localy when the call to remote DS is successfull',
        () async {
          //arrange
          when(() => _mockRemoteDS.getRandonNumberTrivia())
              .thenAnswer((_) async => _tNumberTriviaModel);

          //act
          await _repo.getRandonNumberTrivia();

          //assert
          verify(() => _mockRemoteDS.getRandonNumberTrivia());
          verify(() => _mockLocalDS.cacheNumberTrivia(_tNumberTriviaModel));
        },
      );

      test(
        'should return ServerFailure when the call to remote DS is unsuccessfull',
        () async {
          //arrange
          when(() => _mockRemoteDS.getRandonNumberTrivia())
              .thenThrow(ServerException());

          //act
          final result = await _repo.getRandonNumberTrivia();

          //assert
          verify(() => _mockRemoteDS.getRandonNumberTrivia());
          verifyZeroInteractions(_mockLocalDS);
          expect(result, const Left(ServerFailure()));
        },
      );
    });

    runTestsOfline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          //arrange
          when(() => _mockLocalDS.getLastNumberTrivia())
              .thenAnswer((invocation) async => _tNumberTriviaModel);

          //act
          final result = await _repo.getRandonNumberTrivia();

          //assert
          verifyZeroInteractions(_mockRemoteDS);
          verify(() => _mockLocalDS.getLastNumberTrivia());
          expect(result, const Right(_tNumberTrivia));
        },
      );

      test(
        'should return CacheFailure when there is no cached data is present',
        () async {
          //arrange
          when(() => _mockLocalDS.getLastNumberTrivia())
              .thenThrow(CacheException());

          //act
          final result = await _repo.getRandonNumberTrivia();

          //assert
          verifyZeroInteractions(_mockRemoteDS);
          verify(() => _mockLocalDS.getLastNumberTrivia());
          expect(result, const Left(CacheFailure()));
        },
      );
    });
  });
}

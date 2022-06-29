import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_project/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl _netwokInfo;
  late MockDataConnectionChecker _mockDataConnectionChecker;

  setUp(() {
    _mockDataConnectionChecker = MockDataConnectionChecker();
    _netwokInfo = NetworkInfoImpl(_mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        //arrange
        final tHasConnectionFuture = Future.value(true);

        when(() => _mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);

        //act
        final result = _netwokInfo.isConnected;

        //assert
        verify(() => _mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}

import 'package:covid19_app/core/network/network.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isOnline', () {
    test(
      'should determine that DataConnectionChecker.hasConnection',
          () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final res = networkInfo.isConnected;
        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(res, tHasConnectionFuture);
      },
    );
  });
}

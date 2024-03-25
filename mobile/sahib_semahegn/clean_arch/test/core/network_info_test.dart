import 'package:clean_arch/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  group('isConnected', () {
    MockInternetConnectionChecker mockInternetConnectionChecker =
        MockInternetConnectionChecker();
    NetworkInfoImpl networkInfo =
        NetworkInfoImpl(mockInternetConnectionChecker);
    Future<bool> connected = Future.value(true);
    test('should forward call to internetConnectionChecker', () {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => connected);

      final result = networkInfo.isConnected;
      verify(mockInternetConnectionChecker.hasConnection);

      expect(result, connected);
    });
  });
}

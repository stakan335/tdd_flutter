import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetwokInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetwokInfo {
  const NetworkInfoImpl(this.connectionChecker);

  final InternetConnectionChecker connectionChecker;
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

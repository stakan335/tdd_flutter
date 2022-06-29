import 'package:equatable/equatable.dart';
import 'package:test_project/generated/l10n.dart';

abstract class Failure extends Equatable {
  const Failure();

  String get msg => '';

  @override
  List<Object> get props => [];
}

class DefaultFailure extends Failure {
  const DefaultFailure();

  @override
  String get msg => S.current.defaultFailureMsg;
}

//General failures
class ServerFailure extends Failure {
  const ServerFailure();

  @override
  String get msg => S.current.serverFailureMsg;
}

class CacheFailure extends Failure {
  const CacheFailure();

  @override
  String get msg => S.current.cacheFailureMsg;
}

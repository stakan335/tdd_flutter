import 'package:dartz/dartz.dart';
import 'package:test_project/core/error/failures.dart';

extension StringExt on String {
  Either<InvalidInputFailure, int> toUnsignedInt() {
    final result = int.tryParse(this);

    if (result == null) {
      return Left(InvalidInputFailure());
    }

    if (result < 0) {
      return Left(InvalidInputFailure());
    }

    return Right(result);
  }
}

class InvalidInputFailure extends Failure {}

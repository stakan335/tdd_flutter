import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/core/extensions/string_ext.dart';

void main() {
  group('stringToUnsignedint', () {
    test(
      'should return an int when the string represents an unsigned String',
      () async {
        //arrange
        const str = '123';
        //act
        final result = str.toUnsignedInt();
        //assert
        expect(result, const Right(123));
      },
    );

    test(
      'should return Failure when the string is not an integer',
      () async {
        //arrange
        const str = 'abc';
        //act
        final result = str.toUnsignedInt();
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return Failure when the string is a negative int',
      () async {
        //arrange
        const str = '-123';
        //act
        final result = str.toUnsignedInt();
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}

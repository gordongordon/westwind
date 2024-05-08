
import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';

class InputConverter {
Either<Failure, int> stringToUnsignedInteger(String str) {
  try {
    final integer = int.parse(str);
    if (integer < 0) throw FormatException();
    return Right(integer);
  } on FormatException {
    return Left(InvalidInputFailure());
  }
}
}

class InvalidInputFailure extends Failure {}
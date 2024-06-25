import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';

extension MyDateExtension on DateTime {
  DateTime getDateOnly() {
    return DateTime(
      year,
      month,
      day,
    );
  }
}

extension MyFoldResult<L extends Failure, R> on Either<L, R> {
  R foldResult() {
    return fold(
      (failure) => throw failure, // Throw the error if it exists
      (success) => success, // Return the result if there's no error
    );
  }
}

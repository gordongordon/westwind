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

  bool isSameDay( DateTime date) {
  return year == date.year &&
         month == date.month &&
         day == date.day;
  }   
  
  DateTime getSystemDate() {
    return DateTime.now().getDateOnly();
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

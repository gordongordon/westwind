import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:intl/intl.dart';

extension MyDateExtension on DateTime {
  String getDDMM() {
    return DateFormat('dd-MM').format(this);
  }

  String getMonthName() {
    return DateFormat('MMM').format(this);
  }

  DateTime getDateOnly() {
    return DateTime(year, month, day);
  }

  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }
  
  DateTime getSystemDate() {
    return DateTime.now().getDateOnly();
  }

  String getDDMonthName() {
    return DateFormat('dd-MMM').format(this);
  }

  String getMonthNameDD() {
 return DateFormat('MMM-dd').format(this);
  }

  String getDDDMMAndHours() {
  return DateFormat('DD MMM HH').format(this);
}

String getMonthDayHour() {
  return DateFormat('MMMM d ha').format(this);
}

  static String getMonthNameFromNumber(int monthNumber) {
    if (monthNumber < 1 || monthNumber > 12) {
      throw ArgumentError('Month number must be between 1 and 12');
    }
    return DateFormat('MMM').format(DateTime(2024, monthNumber, 1));
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

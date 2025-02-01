import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Gets the current date in Edmonton timezone, stripped of time components
DateTime getCurrentEdmontonDate() {
  tz.initializeTimeZones();
  final edmonton = tz.getLocation('America/Edmonton');

  // Get current time in Edmonton
  final edmontonNow = tz.TZDateTime.now(edmonton);

  // Create new DateTime with just the date components in Edmonton timezone
  final edmontonDate = tz.TZDateTime(
    edmonton,
    edmontonNow.year,
    edmontonNow.month,
    edmontonNow.day,
  );

  // Convert to UTC for storage/comparison
  return edmontonDate.toUtc();
}

extension MyDateExtension on DateTime {

  String getYYMMDDWeekday() {
    const List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return "$year ${months[month - 1]} $day ${weekdays[weekday - 1]}";
  }

  String getMMDDWeekday() {
    const List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  //  return "${months[month - 1]} $day ${weekdays[weekday - 1]}";
    return " ${weekdays[weekday - 1]} ${months[month - 1]} $day";
  }

  String toCompactString() {
    return "${year}${month.toString().padLeft(2, '0')}${day.toString().padLeft(2, '0')}";
  }

  String getDDMM() {
    return DateFormat('dd-MM').format(this);
  }

  String getMonthName() {
    return DateFormat('MMM').format(this);
  }

/**  
  DateTime getDateOnly() {
    final time =  DateTime(year, month, day);

    return edmontonToUtc(time);
  }

*/
  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  DateTime getSystemDate() {
    // final time =  DateTime.now().getDateOnly();

    return edmontonToUtc(DateTime.now().getDateOnly());

    // return DateTime(year)
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

  String getDDDMMAndHoursMinutes() {
    return DateFormat('DD MMM HH:mm').format(this);
  }

  String getMonthDayHour() {
    return DateFormat('MMMM d ha').format(this);
  }

    String getMonthDayHourMinute() {
    return DateFormat('MMMM d h:mm a').format(this);
  }

  static String getMonthNameFromNumber(int monthNumber) {
    if (monthNumber < 1 || monthNumber > 12) {
      throw ArgumentError('Month number must be between 1 and 12');
    }
    return DateFormat('MMM').format(DateTime(2024, monthNumber, 1));
  }

  /// Converts a local Edmonton time to UTC for server storage
  /// [localTime] should be the time input by the user in Edmonton time
  /// Returns UTC DateTime for storage
  DateTime edmontonToUtc(DateTime localTime) {
    tz.initializeTimeZones();
    final edmonton = tz.getLocation('America/Edmonton');
    final edmontonTime = tz.TZDateTime.from(localTime, edmonton);
    return edmontonTime.toUtc();
  }

  /// Converts UTC time from server to Edmonton time for display
  /// [utcTime] should be the UTC time from the server
  /// Returns DateTime in Edmonton timezone
  DateTime utcToEdmonton(DateTime utcTime) {
    tz.initializeTimeZones();
    final edmonton = tz.getLocation('America/Edmonton');
    return tz.TZDateTime.from(utcTime, edmonton);
  }

// Example usage for display:
  void displayCheckInTime(DateTime serverUtcTime) {
    // Convert UTC time from server to Edmonton time for display
    final localTime = utcToEdmonton(serverUtcTime);
    print('Check-in time (Edmonton): $localTime');
  }

// Should be   DateTime getEdmontonDateOnly() {

  DateTime getDateOnly() {
    tz.initializeTimeZones();
    final edmonton = tz.getLocation('America/Edmonton');

    // Convert this DateTime to Edmonton timezone first
    final edmontonTime = tz.TZDateTime.from(this, edmonton);

    // Create new DateTime with just the date components
    final edmontonDate = tz.TZDateTime(
      edmonton,
      edmontonTime.year,
      edmontonTime.month,
      edmontonTime.day,
    );

    // Convert back to UTC for storage/comparison
    // return edmontonDate.toUtc();
    return edmontonDate;
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

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Singleton class to manage all timezone conversions in the app
class TimeManager {
  static final TimeManager instance = TimeManager._internal();
  late final tz.Location edmonton;
  
  factory TimeManager() {
    return instance;
  }

  TimeManager._internal() {
    tz.initializeTimeZones();
    edmonton = tz.getLocation('America/Edmonton');
  }

  /// Convert server UTC time to Edmonton local time
  DateTime fromServer(DateTime utcTime) {
    if (!utcTime.isUtc) {
      throw TimeFormatException('Server time must be in UTC');
    }
    return tz.TZDateTime.from(utcTime, edmonton);
  }

  /// Convert Edmonton local time to UTC for server
  DateTime toServer(DateTime localTime) {
    final edmontonTime = tz.TZDateTime.from(localTime, edmonton);
    return edmontonTime.toUtc();
  }

  /// Get current Edmonton time
  DateTime now() {
    return tz.TZDateTime.now(edmonton);
  }

  /// Get Edmonton date only (midnight in Edmonton timezone)
  DateTime today() {
    final now = tz.TZDateTime.now(edmonton);
    return tz.TZDateTime(
      edmonton,
      now.year,
      now.month,
      now.day,
    );
  }

  /// Format date for display (you can customize this)
  String formatDate(DateTime date) {
    final edmontonDate = tz.TZDateTime.from(date, edmonton);
    return '${edmontonDate.year}-${edmontonDate.month.toString().padLeft(2, '0')}-${edmontonDate.day.toString().padLeft(2, '0')}';
  }
}

class TimeFormatException implements Exception {
  final String message;
  TimeFormatException(this.message);
  @override
  String toString() => message;
}
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

/// Repository that handles data loading and caching for the room calendar
abstract class CalendarDataRepository {
  /// Fetches reservations for a specific date window
  Future<Either<Failure, List<Reservation>>> fetchReservationsForWindow(
      DateTime startDate, DateTime endDate);
      
  /// Fetches room transactions for a specific date window
  Future<Either<Failure, List<RoomTransaction>>> fetchTransactionsForWindow(
      DateTime startDate, DateTime endDate);
  
  /// Fetches room guests for a specific date window
  Future<Either<Failure, List<RoomGuest>>> fetchRoomGuestsForWindow(
      DateTime startDate, DateTime endDate);
      
  /// Fetches all data needed for the calendar for a specific date window
  /// Returns a tuple with reservations, transactions, and room guests
  Future<Either<Failure, (List<Reservation>, List<RoomTransaction>, List<RoomGuest>)>> 
      fetchCalendarDataForWindow(DateTime startDate, DateTime endDate);
      
  /// Invalidates cache for a specific date or date range
  void invalidateCacheForDate(DateTime date);
  
  /// Invalidates cache for a date range
  void invalidateCacheForDateRange(DateTime startDate, DateTime endDate);
  
  /// Clears all cached data
  void clearCache();
}
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/calendar/domain/repositories/calendar_data_repository.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

// Add this to your CalendarDataRepository class or to a separate file

/// A simple global flag to track if data has been modified
class GlobalCacheManager {
  // Singleton instance
  static final GlobalCacheManager _instance = GlobalCacheManager._internal();
  
  // Private constructor
  GlobalCacheManager._internal();
  
  // Factory constructor
  factory GlobalCacheManager() {
    return _instance;
  }
  
  // Flag to track if data has been modified since last calendar load
  bool _dataModified = false;
  
  // Check if data has been modified
  bool get isDataModified => _dataModified;
  
  // Mark data as modified
  void markDataModified() {
    _dataModified = true;
  }
  
  // Reset the flag
  void resetDataModifiedFlag() {
    _dataModified = false;
  }
}


/// A cache entry with expiration time
class _CacheEntry<T> {
  final T data;
  final DateTime expirationTime;

  _CacheEntry({
    required this.data,
    required this.expirationTime,
  });

  bool get isExpired => TimeManager.instance.now().isAfter(expirationTime);
}

/// A normalized date key for cache maps
/// This removes time components and ensures consistent equality
class _DateKey {
  final int year;
  final int month;
  final int day;

  _DateKey(DateTime date)
      : year = date.year,
        month = date.month,
        day = date.day;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _DateKey &&
        other.year == year &&
        other.month == month &&
        other.day == day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  DateTime toDateTime() {
    return DateTime(year, month, day);
  }
}

/// Implementation of CalendarDataRepository that handles caching
class CalendarDataRepositoryImpl implements CalendarDataRepository {
  final ReservationRepository reservationRepository;
  final RoomTransactionRepository roomTransactionRepository;
  final RoomGuestRepository roomGuestRepository;
  
  // Cache settings
  static const Duration _cacheDuration = Duration(minutes: 5);
  static const int _maxCacheEntries = 90; // Maximum days to keep in cache
  
  // Cache for each data type, keyed by normalized date
  final Map<_DateKey, _CacheEntry<List<Reservation>>> _reservationCache = {};
  final Map<_DateKey, _CacheEntry<List<RoomTransaction>>> _transactionCache = {};
  final Map<_DateKey, _CacheEntry<List<RoomGuest>>> _roomGuestCache = {};
  
  // Cache for combined data
  final Map<_DateKey, _CacheEntry<(List<Reservation>, List<RoomTransaction>, List<RoomGuest>)>> _combinedCache = {};
  
  // Window-based loading tracking
  DateTime? _lastLoadedStartDate;
  DateTime? _lastLoadedEndDate;
  static const int _windowSize = 30; // Days to load at once

  CalendarDataRepositoryImpl({
    required this.reservationRepository,
    required this.roomTransactionRepository,
    required this.roomGuestRepository,
  });

  @override
  Future<Either<Failure, List<Reservation>>> fetchReservationsForWindow(
      DateTime startDate, DateTime endDate) async {
    try {
      // Check cache first
      final cachedData = _getCachedReservations(startDate);
      if (cachedData != null) {
        return Right(cachedData);
      }
      
      // Not in cache, fetch fresh data from repository
      final result = await reservationRepository.findReservatioinsForWindow(startDate, endDate);
      
      // Cache the result if successful
      result.fold(
        (failure) => {}, // Do nothing on failure
        (reservations) => _updateReservationCache(startDate, reservations)
      );
      
      return result;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RoomTransaction>>> fetchTransactionsForWindow(
      DateTime startDate, DateTime endDate) async {
    try {
      // Check cache first
      final cachedData = _getCachedTransactions(startDate);
      if (cachedData != null) {
        return Right(cachedData);
      }
      
      // Not in cache, fetch fresh data from repository
      final result = await roomTransactionRepository.findRoomTransactionsForWindow(startDate, endDate);
      
      // Cache the result if successful
      result.fold(
        (failure) => {}, // Do nothing on failure
        (transactions) => _updateTransactionCache(startDate, transactions)
      );
      
      return result;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RoomGuest>>> fetchRoomGuestsForWindow(
      DateTime startDate, DateTime endDate) async {
    try {
      // Check cache first
      final cachedData = _getCachedRoomGuests(startDate);
      if (cachedData != null) {
        return Right(cachedData);
      }
      
      // Not in cache, always fetch fresh data for room guests
      final result = await roomGuestRepository.findRoomGuestsForWindow(startDate, endDate);
      
      // Cache the result if successful
      result.fold(
        (failure) => {}, // Do nothing on failure
        (roomGuests) => _updateRoomGuestCache(startDate, roomGuests)
      );
      
      return result;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, (List<Reservation>, List<RoomTransaction>, List<RoomGuest>)>> 
      fetchCalendarDataForWindow(DateTime startDate, DateTime endDate) async {
    try {
      // Check if data is within current window
      if (_isDateInCurrentWindow(startDate)) {
        final cachedData = _getCachedCombinedData(startDate);
        if (cachedData != null) {
          return Right(cachedData);
        }
      }
      
      // Calculate window dates
      final windowStart = _calculateWindowStart(startDate);
      final windowEnd = windowStart.add(Duration(days: _windowSize));
      
      // Fetch all data in parallel
      final reservationsResult = await fetchReservationsForWindow(windowStart, windowEnd);
      final transactionsResult = await fetchTransactionsForWindow(windowStart, windowEnd);
      final roomGuestsResult = await fetchRoomGuestsForWindow(windowStart, windowEnd);
      
      // Handle errors in any of the requests
      if (reservationsResult.isLeft()) {
        return Left((reservationsResult as Left).value);
      }
      if (transactionsResult.isLeft()) {
        return Left((transactionsResult as Left).value);
      }
      if (roomGuestsResult.isLeft()) {
        return Left((roomGuestsResult as Left).value);
      }
      
      // Extract data from Either results
      final reservations = (reservationsResult as Right).value as List<Reservation>;
      final transactions = (transactionsResult as Right).value as List<RoomTransaction>;
      final roomGuests = (roomGuestsResult as Right).value as List<RoomGuest>;
      
      // Create combined result
      final combinedData = (reservations, transactions, roomGuests);
      
      // Update cache and window tracking
      _updateCombinedCache(windowStart, combinedData);
      _lastLoadedStartDate = windowStart;
      _lastLoadedEndDate = windowEnd;
      
      // Preload next window if needed (can be done asynchronously)
      _preloadNextWindowIfNeeded(startDate);
      
      return Right(combinedData);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  void invalidateCacheForDate(DateTime date) {
    final dateKey = _DateKey(date);
    _reservationCache.remove(dateKey);
    _transactionCache.remove(dateKey);
    _roomGuestCache.remove(dateKey);
    _combinedCache.remove(dateKey);
  }

  @override
  void invalidateCacheForDateRange(DateTime startDate, DateTime endDate) {
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      invalidateCacheForDate(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
    
    // Also clear the window tracking to force a fresh load
    _lastLoadedStartDate = null;
    _lastLoadedEndDate = null;
  }

  @override
  void clearCache() {
    _reservationCache.clear();
    _transactionCache.clear();
    _roomGuestCache.clear();
    _combinedCache.clear();
    _lastLoadedStartDate = null;
    _lastLoadedEndDate = null;
  }

  // Private helper methods
  bool _isDateInCurrentWindow(DateTime date) {
    if (_lastLoadedStartDate == null || _lastLoadedEndDate == null) {
      return false;
    }
    return date.isAfter(_lastLoadedStartDate!.subtract(const Duration(days: 1))) &&
        date.isBefore(_lastLoadedEndDate!.add(const Duration(days: 1)));
  }

  DateTime _calculateWindowStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  void _preloadNextWindowIfNeeded(DateTime currentDate) async {
    if (_lastLoadedEndDate != null &&
        currentDate.isAfter(
            _lastLoadedEndDate!.subtract(Duration(days: _windowSize ~/ 2)))) {
      // Preload next window
      final nextWindowStart = _lastLoadedEndDate!.add(const Duration(days: 1));
      final nextWindowEnd = nextWindowStart.add(Duration(days: _windowSize));
      fetchCalendarDataForWindow(nextWindowStart, nextWindowEnd);
    }
  }

  // Cache management methods
  void _updateReservationCache(DateTime date, List<Reservation> reservations) {
    final dateKey = _DateKey(date);
    _manageCacheSize(_reservationCache);
    _reservationCache[dateKey] = _CacheEntry(
      data: reservations,
      expirationTime: TimeManager.instance.now().add(_cacheDuration),
    );
  }

  void _updateTransactionCache(DateTime date, List<RoomTransaction> transactions) {
    final dateKey = _DateKey(date);
    _manageCacheSize(_transactionCache);
    _transactionCache[dateKey] = _CacheEntry(
      data: transactions,
      expirationTime: TimeManager.instance.now().add(_cacheDuration),
    );
  }

  void _updateRoomGuestCache(DateTime date, List<RoomGuest> roomGuests) {
    final dateKey = _DateKey(date);
    _manageCacheSize(_roomGuestCache);
    _roomGuestCache[dateKey] = _CacheEntry(
      data: roomGuests,
      expirationTime: TimeManager.instance.now().add(_cacheDuration),
    );
  }

  void _updateCombinedCache(DateTime date, (List<Reservation>, List<RoomTransaction>, List<RoomGuest>) data) {
    final dateKey = _DateKey(date);
    _manageCacheSize(_combinedCache);
    _combinedCache[dateKey] = _CacheEntry(
      data: data,
      expirationTime: TimeManager.instance.now().add(_cacheDuration),
    );
  }

  void _manageCacheSize<T>(Map<_DateKey, _CacheEntry<T>> cache) {
    // Remove old entries if cache is too large
    if (cache.length > _maxCacheEntries) {
      final oldestDate = cache.keys
          .map((key) => key.toDateTime())
          .reduce((a, b) => a.isBefore(b) ? a : b);
      cache.remove(_DateKey(oldestDate));
    }
  }

  List<Reservation>? _getCachedReservations(DateTime date) {
    final dateKey = _DateKey(date);
    final entry = _reservationCache[dateKey];
    if (entry == null || entry.isExpired) {
      _reservationCache.remove(dateKey);
      return null;
    }
    return entry.data;
  }

  List<RoomTransaction>? _getCachedTransactions(DateTime date) {
    final dateKey = _DateKey(date);
    final entry = _transactionCache[dateKey];
    if (entry == null || entry.isExpired) {
      _transactionCache.remove(dateKey);
      return null;
    }
    return entry.data;
  }

  List<RoomGuest>? _getCachedRoomGuests(DateTime date) {
    final dateKey = _DateKey(date);
    final entry = _roomGuestCache[dateKey];
    if (entry == null || entry.isExpired) {
      _roomGuestCache.remove(dateKey);
      return null;
    }
    return entry.data;
  }

  (List<Reservation>, List<RoomTransaction>, List<RoomGuest>)? _getCachedCombinedData(DateTime date) {
    final dateKey = _DateKey(date);
    final entry = _combinedCache[dateKey];
    if (entry == null || entry.isExpired) {
      _combinedCache.remove(dateKey);
      return null;
    }
    return entry.data;
  }
}
// room_calendar_bloc.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/room/domain/repositories/room_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

part 'room_calendar_event.dart';
part 'room_calendar_state.dart';

// Cache entry class for storing state with expiration
class _CacheEntry {
  final RoomCalendarLoaded state;
  final DateTime expirationTime;

  _CacheEntry({
    required this.state,
    required this.expirationTime,
  });

  bool get isExpired => TimeManager.instance.now().isAfter(expirationTime);
}

class RoomCalendarBloc extends Bloc<RoomCalendarEvent, RoomCalendarState> {
  final ReservationRepository reservationRepository;
  final RoomTransactionRepository roomTransactionRepository;
  final RoomGuestRepository roomGuestRepository;
  final RoomRepository roomRepository;

  // Cache settings
  final Map<DateTime, _CacheEntry> _stateCache = {};
  static const Duration _cacheDuration = Duration(minutes: 5);
  static const int _maxCacheEntries = 90; // Maximum days to keep in cache

  // Window-based loading settings
  static const int _windowSize = 30; // Days to load at once
  DateTime? _lastLoadedStartDate;
  DateTime? _lastLoadedEndDate;

  RoomCalendarBloc({
    required this.reservationRepository,
    required this.roomTransactionRepository,
    required this.roomGuestRepository,
    required this.roomRepository,
  }) : super(RoomCalendarInitial()) {
    on<InitializeCalendar>(_onInitializeCalendar);
    on<FetchReservationsAndTransactions>(_onFetchReservationsAndTransactions);
    on<ChangeStartDate>(_onChangeStartDate);
    on<ChangeDaysToShow>(_onChangeDaysToShow);
    on<MoveReservation>(_onMoveReservation);
    on<MoveRoomGuest>(_onMoveRoomGuest);
    on<AddReservationToCell>(_onAddReservationToCell);
    on<NavigateCalendarDays>(_onNavigateCalendarDays);
    on<NavigateCalendarWeeks>(_onNavigateCalendarWeeks);
    on<SelectSpecificDate>(_onSelectSpecificDate);
    on<ToggleRoomStatus>(_onToggleRoomStatus);
  }

  void _onInitializeCalendar(
      InitializeCalendar event, Emitter<RoomCalendarState> emit) async {
    emit(RoomCalendarLoading());

    try {
      final rooms = (await roomRepository.list()).foldResult();
      final roomTypes = rooms.map((room) => room.roomType.toString()).toList();
      final roomNumbers = rooms.map((room) => room.id!.toString()).toList();
      final roomStatus =
          rooms.map((room) => room.roomStatus.toString()).toList();

      final startDate =
          TimeManager.instance.today().subtract(const Duration(days: 1));
      const int daysToShow = 14;

      final initialState = RoomCalendarLoaded(
        roomTypes: roomTypes,
        roomNumbers: roomNumbers,
        roomStatus: roomStatus,
        startDate: startDate,
        daysToShow: daysToShow,
        reservations: const [],
        reservationsByRoom: const {},
        roomTransactions: const [],
        roomTransactionsByRoom: const {},
        roomGuests: const [],
        roomGuestsByRoom: const {},
      );

      emit(initialState);
      add(FetchReservationsAndTransactions(startDate));
    } catch (e) {
      emit(RoomCalendarError(message: 'Failed to fetch data: ${e.toString()}'));
    }
  }

  Future<void> _onFetchReservationsAndTransactions(
      FetchReservationsAndTransactions event,
      Emitter<RoomCalendarState> emit) async {
    try {
      // Check if date is within current window
      if (_isDateInCurrentWindow(event.startDate)) {
        final cachedState = _getCachedState(event.startDate);
        if (cachedState != null) {
          emit(cachedState);
          return;
        }
      }

      emit(RoomCalendarLoading());

      // Calculate window dates
      final windowStart = _calculateWindowStart(event.startDate);
      final windowEnd = windowStart.add(Duration(days: _windowSize));

      // Fetch data for the window
      final reservations =
          await _fetchReservationsForWindow(windowStart, windowEnd);
      final transactions =
          await _fetchTransactionsForWindow(windowStart, windowEnd);
      final roomGuests =
          await _fetchRoomGuestsForWindow(windowStart, windowEnd);

      // Process and emit state
      final newState = await _processAndCreateState(
        windowStart,
        reservations,
        transactions,
        roomGuests,
      );

      // Update cache and window tracking
      _updateCache(windowStart, newState);
      _lastLoadedStartDate = windowStart;
      _lastLoadedEndDate = windowEnd;

      emit(newState);

      // Preload next window if needed
      _preloadNextWindowIfNeeded(event.startDate);
    } catch (e) {
      emit(RoomCalendarError(message: 'Failed to fetch data: ${e.toString()}'));
    }
  }

  void _onChangeStartDate(
      ChangeStartDate event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedState = currentState.copyWith(startDate: event.newStartDate);
      emit(updatedState);

      if (!_isDateInCurrentWindow(event.newStartDate)) {
        add(FetchReservationsAndTransactions(event.newStartDate));
      }
    }
  }

  void _onChangeDaysToShow(
      ChangeDaysToShow event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedState =
          currentState.copyWith(daysToShow: event.newDaysToShow);
      emit(updatedState);
      _invalidateCache();
      add(FetchReservationsAndTransactions(currentState.startDate));
    }
  }

  Future<void> _onMoveReservation(
      MoveReservation event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedReservation = _updateReservationForMove(
          event.reservation, event.newRoomNumber, event.newStartDate);

      final saveResult = await reservationRepository.save(updatedReservation);

      await saveResult.fold(
        (failure) async => emit(RoomCalendarError(
            message: "Failed to move reservation: ${failure.message}")),
        (savedReservation) async {
          final updatedState = _updateStateAfterReservationMove(
              currentState, event.reservation, savedReservation);

          _updateCacheForDateRange(savedReservation.stayDay,
              savedReservation.checkOutDate, updatedState);

          emit(updatedState);
        },
      );
    }
  }

  Future<void> _onMoveRoomGuest(
      MoveRoomGuest event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedRoomGuest = _updateRoomGuestForMove(
          event.roomGuest, event.newRoomNumber, event.newStayDate);

      final saveResult =
          await roomGuestRepository.save(roomGuest: updatedRoomGuest);

      await saveResult.fold(
        (failure) async => emit(RoomCalendarError(
            message: "Failed to move room guest: ${failure.message}")),
        (savedRoomGuest) async {
          final updatedState = _updateStateAfterRoomGuestMove(
              currentState, event.roomGuest, savedRoomGuest);

          _updateCacheForDateRange(savedRoomGuest.stayDay,
              savedRoomGuest.checkOutDate, updatedState);

          emit(updatedState);
        },
      );
    }
  }

  Future<void> _onAddReservationToCell(
      AddReservationToCell event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedReservation = _updateReservationForCell(
          event.reservation, event.roomNumber, event.date);

      final saveResult = await reservationRepository.save(updatedReservation);

      await saveResult.fold(
        (failure) async => emit(RoomCalendarError(
            message: "Failed to save reservation: ${failure.message}")),
        (savedReservation) async {
          final updatedState =
              _updateStateAfterReservationAdd(currentState, savedReservation);

          _updateCacheForDateRange(savedReservation.stayDay,
              savedReservation.checkOutDate, updatedState);

          emit(updatedState);
        },
      );
    }
  }

  void _onNavigateCalendarDays(
      NavigateCalendarDays event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final newStartDate =
          currentState.startDate.add(Duration(days: event.days));
      emit(currentState.copyWith(startDate: newStartDate));

      if (!_isDateInCurrentWindow(newStartDate)) {
        add(FetchReservationsAndTransactions(newStartDate));
      }
    }
  }

  void _onNavigateCalendarWeeks(
      NavigateCalendarWeeks event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final newStartDate =
          currentState.startDate.add(Duration(days: event.weeks * 7));
      emit(currentState.copyWith(startDate: newStartDate));

      if (!_isDateInCurrentWindow(newStartDate)) {
        add(FetchReservationsAndTransactions(newStartDate));
      }
    }
  }

  void _onSelectSpecificDate(
      SelectSpecificDate event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(startDate: event.selectedDate));

      if (!_isDateInCurrentWindow(event.selectedDate)) {
        add(FetchReservationsAndTransactions(event.selectedDate));
      }
    }
  }

  void _onToggleRoomStatus(
      ToggleRoomStatus event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;

      final saveResult = await roomRepository.toggleRoomStatus(event.roomId);

      await saveResult.fold(
        (failure) async => emit(RoomCalendarError(
            message: "Failed to toggle room status: ${failure.message}")),
        (savedRoom) async {
          final rooms = (await roomRepository.list()).foldResult();
          final roomStatus =
              rooms.map((room) => room.roomStatus.toString()).toList();
          emit(currentState.copyWith(roomStatus: roomStatus));
        },
      );
    }
  }

  bool _isDateInCurrentWindow(DateTime date) {
    if (_lastLoadedStartDate == null || _lastLoadedEndDate == null)
      return false;
    return date.isAfter(_lastLoadedStartDate!) &&
        date.isBefore(_lastLoadedEndDate!);
  }

  DateTime _calculateWindowStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }


  //! Add implement this in serverpod 
  //e.g. fetchReservationsForWindows in Serverside

  Future<List<Reservation>> _fetchReservationsForWindow(
      DateTime start, DateTime end) async {
    final result = await reservationRepository.findReservatioinsForWindow(start,end);
    return result.fold(
      (failure) => [],
      (reservations) => reservations
    );
  }
/*
  Future<List<Reservation>> _fetchReservationsForWindow(
      DateTime start, DateTime end) async {
    final result = await reservationRepository.list();
    return result.fold(
      (failure) => [],
      (reservations) => reservations
          .where((res) =>
              res.stayDay.isAfter(start.subtract(const Duration(days: 1))) &&
              res.stayDay.isBefore(end.add(const Duration(days: 1))) &&
              !res.isCanceled &&
              !res.isCheckedIn)
          .toList(),
    );
  }
  */
  //! Add implement this in serverpod 
  Future<List<RoomTransaction>> _fetchTransactionsForWindow(
      DateTime start, DateTime end) async {
    final result = await roomTransactionRepository.findRoomTransactionsForWindow(start,end);
    return result.fold(
      (failure) => [],
      (transactions) => transactions,
    );


/*
      (transactions) => transactions
          .where((trans) =>
              trans.stayDay.isAfter(start.subtract(const Duration(days: 1))) &&
              trans.stayDay.isBefore(end.add(const Duration(days: 1))))
          .toList(),
    );*/
  }

  Future<List<RoomGuest>> _fetchRoomGuestsForWindow(
      DateTime start, DateTime end) async {
    final result = await roomGuestRepository.findRoomGuestsForWindow(start, end);
    return result.fold(
      (failure) => [],
      (guests) => guests,
    );
  }

/*
  Future<List<RoomGuest>> _fetchRoomGuestsForWindow(
      DateTime start, DateTime end) async {
    final result = await roomGuestRepository.list();
    return result.fold(
      (failure) => [],
      (guests) => guests
          .where((guest) =>
              guest.stayDay.isAfter(start.subtract(const Duration(days: 1))) &&
              guest.stayDay.isBefore(end.add(const Duration(days: 1))) &&
              !guest.isCheckOut)
          .toList(),
    );
  }
  */

  Future<RoomCalendarLoaded> _processAndCreateState(
    DateTime startDate,
    List<Reservation> reservations,
    List<RoomTransaction> transactions,
    List<RoomGuest> roomGuests,
  ) async {
    final rooms = (await roomRepository.list()).foldResult();

    return RoomCalendarLoaded(
      roomTypes: rooms.map((room) => room.roomType.toString()).toList(),
      roomNumbers: rooms.map((room) => room.id!.toString()).toList(),
      roomStatus: rooms.map((room) => room.roomStatus.toString()).toList(),
      startDate: startDate,
      daysToShow: _windowSize,
      reservations: reservations,
      reservationsByRoom: _groupReservationsByRoom(reservations),
      roomTransactions: transactions,
      roomTransactionsByRoom: _groupRoomTransactionsByRoom(transactions),
      roomGuests: roomGuests,
      roomGuestsByRoom: _groupRoomGuestsByRoom(roomGuests),
    );
  }

  void _updateCache(DateTime date, RoomCalendarLoaded state) {
    // Remove old entries if cache is too large
    if (_stateCache.length > _maxCacheEntries) {
      final oldestDate =
          _stateCache.keys.reduce((a, b) => a.isBefore(b) ? a : b);
      _stateCache.remove(oldestDate);
    }

    // Add new entry with expiration
    _stateCache[date] = _CacheEntry(
      state: state,
      expirationTime: TimeManager.instance.now().add(_cacheDuration),
    );
  }

  void _updateCacheForDateRange(
      DateTime startDate, DateTime endDate, RoomCalendarLoaded state) {
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      _updateCache(currentDate, state);
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  RoomCalendarLoaded? _getCachedState(DateTime date) {
    final entry = _stateCache[date];
    if (entry == null || entry.isExpired) {
      _stateCache.remove(date);
      return null;
    }
    return entry.state;
  }

  void _invalidateCache() {
    _stateCache.clear();
  }

  void _preloadNextWindowIfNeeded(DateTime currentDate) {
    if (_lastLoadedEndDate != null &&
        currentDate.isAfter(
            _lastLoadedEndDate!.subtract(Duration(days: _windowSize ~/ 2)))) {
      // Preload next window
      add(FetchReservationsAndTransactions(
          _lastLoadedEndDate!.add(const Duration(days: 1))));
    }
  }

  Map<String, List<Reservation>> _groupReservationsByRoom(
      List<Reservation> reservations) {
    final Map<String, List<Reservation>> reservationsByRoom = {};
    for (var reservation in reservations) {
      final roomId = reservation.roomId.toString();
      if (!reservationsByRoom.containsKey(roomId)) {
        reservationsByRoom[roomId] = [];
      }
      reservationsByRoom[roomId]!.add(reservation);
    }
    return reservationsByRoom;
  }

  Map<String, List<RoomTransaction>> _groupRoomTransactionsByRoom(
      List<RoomTransaction> roomTransactions) {
    final Map<String, List<RoomTransaction>> roomTransactionsByRoom = {};
    for (var transaction in roomTransactions) {
      if (transaction.itemType == ItemType.room) {
        final roomId = transaction.roomId.toString();
        if (!roomTransactionsByRoom.containsKey(roomId)) {
          roomTransactionsByRoom[roomId] = [];
        }
        roomTransactionsByRoom[roomId]!.add(transaction);
      }
    }
    return roomTransactionsByRoom;
  }

  Map<String, List<RoomGuest>> _groupRoomGuestsByRoom(
      List<RoomGuest> roomGuests) {
    final Map<String, List<RoomGuest>> roomGuestsByRoom = {};
    for (var roomGuest in roomGuests) {
      final roomId = roomGuest.roomId.toString();
      if (!roomGuestsByRoom.containsKey(roomId)) {
        roomGuestsByRoom[roomId] = [];
      }
      roomGuestsByRoom[roomId]!.add(roomGuest);
    }
    return roomGuestsByRoom;
  }

  Reservation _updateReservationForMove(
      Reservation reservation, String newRoomNumber, DateTime newStartDate) {
    final originalDuration =
        reservation.checkOutDate.difference(reservation.stayDay);
    return reservation.copyWith(
      roomId: int.parse(newRoomNumber),
      stayDay: newStartDate,
      checkInDate: newStartDate,
      checkOutDate: newStartDate.add(originalDuration),
    );
  }

  RoomCalendarLoaded _updateStateAfterReservationMove(
      RoomCalendarLoaded currentState,
      Reservation oldReservation,
      Reservation newReservation) {
    final updatedReservations =
        List<Reservation>.from(currentState.reservations);
    final updatedReservationsByRoom =
        Map<String, List<Reservation>>.from(currentState.reservationsByRoom);

    // Remove from old room
    final oldRoomId = oldReservation.roomId.toString();
    updatedReservationsByRoom[oldRoomId]
        ?.removeWhere((r) => r.id == newReservation.id);
    if (updatedReservationsByRoom[oldRoomId]?.isEmpty ?? false) {
      updatedReservationsByRoom.remove(oldRoomId);
    }

    // Add to new room
    final newRoomId = newReservation.roomId.toString();
    if (!updatedReservationsByRoom.containsKey(newRoomId)) {
      updatedReservationsByRoom[newRoomId] = [];
    }
    updatedReservationsByRoom[newRoomId]!.add(newReservation);

    // Update main list
    final index =
        updatedReservations.indexWhere((r) => r.id == newReservation.id);
    if (index != -1) {
      updatedReservations[index] = newReservation;
    } else {
      updatedReservations.add(newReservation);
    }

    return currentState.copyWith(
      reservations: updatedReservations,
      reservationsByRoom: updatedReservationsByRoom,
    );
  }

  Reservation _updateReservationForCell(
      Reservation reservation, String roomNumber, DateTime date) {
    return reservation.copyWith(
      roomId: int.parse(roomNumber),
      stayDay: date,
      checkInDate: date,
    );
  }

  RoomCalendarLoaded _updateStateAfterReservationAdd(
      RoomCalendarLoaded currentState, Reservation newReservation) {
    final updatedReservations =
        List<Reservation>.from(currentState.reservations);
    final updatedReservationsByRoom =
        Map<String, List<Reservation>>.from(currentState.reservationsByRoom);

    // Update or add to main list
    final existingIndex =
        updatedReservations.indexWhere((r) => r.id == newReservation.id);
    if (existingIndex != -1) {
      updatedReservations[existingIndex] = newReservation;
    } else {
      updatedReservations.add(newReservation);
    }

    // Update or add to room-specific list
    final roomId = newReservation.roomId.toString();
    if (!updatedReservationsByRoom.containsKey(roomId)) {
      updatedReservationsByRoom[roomId] = [];
    }
    final roomReservations = updatedReservationsByRoom[roomId]!;
    final roomExistingIndex =
        roomReservations.indexWhere((r) => r.id == newReservation.id);
    if (roomExistingIndex != -1) {
      roomReservations[roomExistingIndex] = newReservation;
    } else {
      roomReservations.add(newReservation);
    }

    return currentState.copyWith(
      reservations: updatedReservations,
      reservationsByRoom: updatedReservationsByRoom,
    );
  }

  RoomGuest _updateRoomGuestForMove(
      RoomGuest roomGuest, String newRoomNumber, DateTime newStayDate) {
    return roomGuest.copyWith(
      roomId: int.parse(newRoomNumber),
      stayDay: newStayDate,
    );
  }

  RoomCalendarLoaded _updateStateAfterRoomGuestMove(
      RoomCalendarLoaded currentState,
      RoomGuest oldRoomGuest,
      RoomGuest newRoomGuest) {
    final updatedRoomGuests = List<RoomGuest>.from(currentState.roomGuests);
    final updatedRoomGuestsByRoom =
        Map<String, List<RoomGuest>>.from(currentState.roomGuestsByRoom);

    // Remove from old room
    final oldRoomId = oldRoomGuest.roomId.toString();
    updatedRoomGuestsByRoom[oldRoomId]
        ?.removeWhere((r) => r.id == newRoomGuest.id);
    if (updatedRoomGuestsByRoom[oldRoomId]?.isEmpty ?? false) {
      updatedRoomGuestsByRoom.remove(oldRoomId);
    }

    // Add to new room
    final newRoomId = newRoomGuest.roomId.toString();
    if (!updatedRoomGuestsByRoom.containsKey(newRoomId)) {
      updatedRoomGuestsByRoom[newRoomId] = [];
    }
    updatedRoomGuestsByRoom[newRoomId]!.add(newRoomGuest);

    // Update main list
    final index = updatedRoomGuests.indexWhere((r) => r.id == newRoomGuest.id);
    if (index != -1) {
      updatedRoomGuests[index] = newRoomGuest;
    } else {
      updatedRoomGuests.add(newRoomGuest);
    }

    return currentState.copyWith(
      roomGuests: updatedRoomGuests,
      roomGuestsByRoom: updatedRoomGuestsByRoom,
    );
  }

  @override
  Future<void> close() {
    _invalidateCache();
    return super.close();
  }
}

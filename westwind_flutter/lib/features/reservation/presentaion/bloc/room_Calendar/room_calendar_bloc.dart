// room_calendar_bloc.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/calendar/data/repositories/calendar_darta_repository_imp.dart';
import 'package:westwind_flutter/features/calendar/domain/repositories/calendar_data_repository.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/room/domain/repositories/room_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

part 'room_calendar_event.dart';
part 'room_calendar_state.dart';

class RoomCalendarBloc extends Bloc<RoomCalendarEvent, RoomCalendarState> {
  final CalendarDataRepository calendarDataRepository;
  final ReservationRepository reservationRepository;
  final RoomGuestRepository roomGuestRepository;
  final RoomRepository roomRepository;
 // final GlobalCacheManager _cacheManager = GlobalCacheManager();

  // Window-based loading settings
  static const int _windowSize = 30; // Days to load at once
  DateTime? _lastLoadedStartDate;
  DateTime? _lastLoadedEndDate;

  RoomCalendarBloc({
    required this.calendarDataRepository,
    required this.reservationRepository,
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

   // try {
      // Check if data has been modified from other pages
  //    if (_cacheManager.isDataModified) {
        // Clear the cache if data was modified elsewhere
        calendarDataRepository.clearCache();
        // Reset the flag
  //      _cacheManager.resetDataModifiedFlag();
  //    }

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
    } 
    
 //   catch (e) {
 //     emit(RoomCalendarError(message: 'Failed to fetch data: ${e.toString()}'));
 //   }
 // }

/*

  void _onInitializeCalendar(
      InitializeCalendar event, Emitter<RoomCalendarState> emit) async {
    emit(RoomCalendarLoading());

    try {
      // Force clear all caches to ensure fresh data when returning to calendar
      calendarDataRepository.clearCache();
      
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
  */

  Future<void> _onFetchReservationsAndTransactions(
      FetchReservationsAndTransactions event,
      Emitter<RoomCalendarState> emit) async {
    try {
      // Calculate window dates
      final windowStart = _calculateWindowStart(event.startDate);
      final windowEnd = windowStart.add(Duration(days: _windowSize));

      emit(RoomCalendarLoading());

      // Use the CalendarDataRepository to fetch all required data at once
      final calendarDataResult = await calendarDataRepository
          .fetchCalendarDataForWindow(windowStart, windowEnd);

      await calendarDataResult.fold(
        (failure) async {
          emit(RoomCalendarError(
              message: 'Failed to fetch calendar data: ${failure.message}'));
        },
        (calendarData) async {
          final reservations = calendarData.$1;
          final transactions = calendarData.$2;
          final roomGuests = calendarData.$3;

          // Process and emit state
          final newState = await _processAndCreateState(
            windowStart,
            reservations,
            transactions,
            roomGuests,
          );

          // Update window tracking
          _lastLoadedStartDate = windowStart;
          _lastLoadedEndDate = windowEnd;

          emit(newState);

          // Preload next window if needed
          _preloadNextWindowIfNeeded(event.startDate);
        },
      );
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

      // Invalidate repository cache for the affected date range
      final endDate =
          currentState.startDate.add(Duration(days: event.newDaysToShow));
      calendarDataRepository.invalidateCacheForDateRange(
          currentState.startDate, endDate);

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
          // First update the local state
          final updatedState = _updateStateAfterReservationMove(
              currentState, event.reservation, savedReservation);

          // Invalidate repository cache for the affected date ranges
          // Original reservation dates
          calendarDataRepository.invalidateCacheForDateRange(
              event.reservation.stayDay, event.reservation.checkOutDate);
          // New reservation dates
          calendarDataRepository.invalidateCacheForDateRange(
              savedReservation.stayDay, savedReservation.checkOutDate);

          // Force a reload of data for the affected date range to ensure persistence
          // This is important to keep the state synchronized with the backend
          final windowStart = _calculateWindowStart(savedReservation.stayDay);
          final windowEnd = windowStart.add(Duration(days: _windowSize));

          final freshDataResult = await calendarDataRepository
              .fetchCalendarDataForWindow(windowStart, windowEnd);

          // Emit the updated state first for immediate UI feedback
          emit(updatedState);

          // Then update with fresh data if fetched successfully
          freshDataResult.fold((failure) {
            // Just log the error, we already emitted the updated state
            print(
                "Warning: Failed to refresh data after reservation move: ${failure.message}");
          }, (freshData) async {
            // Only emit a new state if we're still in the same view
            if (state is RoomCalendarLoaded) {
              final currentState = state as RoomCalendarLoaded;
              if (currentState.startDate
                  .isAtSameMomentAs(updatedState.startDate)) {
                final freshState = await _processAndCreateState(
                  windowStart,
                  freshData.$1,
                  freshData.$2,
                  freshData.$3,
                );
                emit(freshState);
              }
            }
          });
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
          // First update the local state
          final updatedState = _updateStateAfterRoomGuestMove(
              currentState, event.roomGuest, savedRoomGuest);

          // Invalidate repository cache for the affected date ranges
          // Original guest dates
          calendarDataRepository.invalidateCacheForDateRange(
              event.roomGuest.stayDay, event.roomGuest.checkOutDate);
          // New guest dates
          calendarDataRepository.invalidateCacheForDateRange(
              savedRoomGuest.stayDay, savedRoomGuest.checkOutDate);

          // Force a reload of data for the affected date range to ensure persistence
          // This is important to keep the state synchronized with the backend
          final windowStart = _calculateWindowStart(savedRoomGuest.stayDay);
          final windowEnd = windowStart.add(Duration(days: _windowSize));

          final freshDataResult = await calendarDataRepository
              .fetchCalendarDataForWindow(windowStart, windowEnd);

          // Emit the updated state first for immediate UI feedback
          emit(updatedState);
//! testing only
    //    _cacheManager.markDataModified();

          // Then update with fresh data if fetched successfully
          freshDataResult.fold((failure) {
            // Just log the error, we already emitted the updated state
            print(
                "Warning: Failed to refresh data after room guest move: ${failure.message}");
          }, (freshData) async {
            // Only emit a new state if we're still in the same view
            if (state is RoomCalendarLoaded) {
              final currentState = state as RoomCalendarLoaded;
              if (currentState.startDate
                  .isAtSameMomentAs(updatedState.startDate)) {
                final freshState = await _processAndCreateState(
                  windowStart,
                  freshData.$1,
                  freshData.$2,
                  freshData.$3,
                );
                emit(freshState);
              }
            }
          });
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
          // First update the local state
          final updatedState =
              _updateStateAfterReservationAdd(currentState, savedReservation);

          // Invalidate repository cache for the affected date range
          calendarDataRepository.invalidateCacheForDateRange(
              savedReservation.stayDay, savedReservation.checkOutDate);

          // Force a reload of data for the affected date range to ensure persistence
          final windowStart = _calculateWindowStart(savedReservation.stayDay);
          final windowEnd = windowStart.add(Duration(days: _windowSize));

          final freshDataResult = await calendarDataRepository
              .fetchCalendarDataForWindow(windowStart, windowEnd);

          // Emit the updated state first for immediate UI feedback
          emit(updatedState);

          // Then update with fresh data if fetched successfully
          freshDataResult.fold((failure) {
            // Just log the error, we already emitted the updated state
            print(
                "Warning: Failed to refresh data after adding reservation: ${failure.message}");
          }, (freshData) async {
            // Only emit a new state if we're still in the same view
            if (state is RoomCalendarLoaded) {
              final currentState = state as RoomCalendarLoaded;
              if (currentState.startDate
                  .isAtSameMomentAs(updatedState.startDate)) {
                final freshState = await _processAndCreateState(
                  windowStart,
                  freshData.$1,
                  freshData.$2,
                  freshData.$3,
                );
                emit(freshState);
              }
            }
          });
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

  void _preloadNextWindowIfNeeded(DateTime currentDate) {
    if (_lastLoadedEndDate != null &&
        currentDate.isAfter(
            _lastLoadedEndDate!.subtract(Duration(days: _windowSize ~/ 2)))) {
      // Preload next window
      final nextWindowStart = _lastLoadedEndDate!.add(const Duration(days: 1));
      add(FetchReservationsAndTransactions(nextWindowStart));
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
    calendarDataRepository.clearCache();
    return super.close();
  }
}

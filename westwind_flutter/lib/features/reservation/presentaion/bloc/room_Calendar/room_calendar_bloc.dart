import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/auth/domain/usecases/current_user.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

part 'room_calendar_event.dart';
part 'room_calendar_state.dart';

class RoomCalendarBloc extends Bloc<RoomCalendarEvent, RoomCalendarState> {
  final ReservationRepository reservationRepository;
  final RoomTransactionRepository roomTransactionRepository;

  RoomCalendarBloc({
    required this.reservationRepository,
    required this.roomTransactionRepository,
  }) : super(RoomCalendarInitial()) {
    on<InitializeCalendar>(_onInitializeCalendar);
    on<FetchReservationsAndTransactions>(_onFetchReservationsAndTransactions);
    on<ChangeStartDate>(_onChangeStartDate);
    on<ChangeDaysToShow>(_onChangeDaysToShow);
    on<MoveReservation>(_onMoveReservation);
    on<AddReservationToCell>(_onAddReservationToCell);
    on<NavigateCalendarDays>(_onNavigateCalendarDays);
    on<NavigateCalendarWeeks>(_onNavigateCalendarWeeks);
    on<SelectSpecificDate>(_onSelectSpecificDate);
  }

  void _onInitializeCalendar(InitializeCalendar event, Emitter<RoomCalendarState> emit) async {
    emit(RoomCalendarLoading());
    
    final List<String> roomTypes = ['Deluxe', 'Suite'];
    final List<String> roomNumbers = List.generate(67, (index) => (101 + index).toString());
    final DateTime startDate = DateTime.now().getDateOnly();
    final int daysToShow = 7;
    
    emit(RoomCalendarLoaded(
      roomTypes: roomTypes,
      roomNumbers: roomNumbers,
      startDate: startDate,
      daysToShow: daysToShow,
      reservations: [],
      reservationsByRoom: {},
      roomTransactions: [],
      roomTransactionsByRoom: {},
    ));

     add(const FetchReservationsAndTransactions());
  }

  Future<void> _onFetchReservationsAndTransactions(
    FetchReservationsAndTransactions event, 
    Emitter<RoomCalendarState> emit
  ) async {
    emit(RoomCalendarLoading());

    try {
      final reservationResult = await reservationRepository.list();
      final roomTransactionResult = await roomTransactionRepository.list();

      final failureOrLoaded = await reservationResult.fold(
        (failure) async => RoomCalendarError(message: failure.message),
        (reservations) async {
          return await roomTransactionResult.fold(
            (failure) async => RoomCalendarError(message: failure.message),
            (roomTransactions) async {
              final Map<String, List<Reservation>> reservationsByRoom = _groupReservationsByRoom(reservations);
              final Map<String, List<RoomTransaction>> roomTransactionsByRoom = _groupRoomTransactionsByRoom(roomTransactions);
              
              if (state is RoomCalendarLoaded) {
                final currentState = state as RoomCalendarLoaded;
                return currentState.copyWith(
                  reservations: reservations,
                  reservationsByRoom: reservationsByRoom,
                  roomTransactions: roomTransactions,
                  roomTransactionsByRoom: roomTransactionsByRoom,
                );
              } else {
                
              // final currentState = state as RoomCalendarLoaded;

              
                return RoomCalendarLoaded(
                  roomTypes: ['Deluxe', 'Suite'],
                  roomNumbers: List.generate(67, (index) => (101 + index).toString()),
                  startDate: DateTime.now().getDateOnly(),
                  daysToShow: 7,
                  reservations: reservations,
                  reservationsByRoom: reservationsByRoom,
                  roomTransactions: roomTransactions,
                  roomTransactionsByRoom: roomTransactionsByRoom,
                );
              }
            },
          );
        },
      );

      emit(failureOrLoaded);
    } catch (e) {
      emit(RoomCalendarError(message: 'Failed to fetch data: ${e.toString()}'));
    }
  }

  void _onChangeStartDate(ChangeStartDate event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(startDate: event.newStartDate));
     // add(const FetchReservationsAndTransactions());
    }
  }

  void _onChangeDaysToShow(ChangeDaysToShow event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(daysToShow: event.newDaysToShow));
     //  add(const FetchReservationsAndTransactions());
    }
  }

  Future<void> _onMoveReservation(MoveReservation event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedReservation = _updateReservationForMove(event.reservation, event.newRoomNumber, event.newStartDate);
      
      final saveResult = await reservationRepository.save(updatedReservation);

      await saveResult.fold(
        (failure) async => emit(RoomCalendarError(message: "Failed to move reservation: ${failure.message}")),
        (savedReservation) async {
          final updatedState = _updateStateAfterReservationMove(currentState, event.reservation, savedReservation);
          emit(updatedState);
          add(FetchReservationsAndTransactions());
        },
      );
    }
  }

  Future<void> _onAddReservationToCell(AddReservationToCell event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final updatedReservation = _updateReservationForCell(event.reservation, event.roomNumber, event.date);
      
      final saveResult = await reservationRepository.save(updatedReservation);

      await saveResult.fold(
        (failure) async => emit(RoomCalendarError(message: "Failed to save reservation: ${failure.message}")),
        (savedReservation) async {
          final updatedState = _updateStateAfterReservationAdd(currentState, savedReservation);
          emit(updatedState);
          add(FetchReservationsAndTransactions());
        },
      );
    }
  }

  void _onNavigateCalendarDays(NavigateCalendarDays event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final newStartDate = currentState.startDate.add(Duration(days: event.days));
      emit(currentState.copyWith(startDate: newStartDate));
   //   add(const FetchReservationsAndTransactions());
    }
  }

  void _onNavigateCalendarWeeks(NavigateCalendarWeeks event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      final newStartDate = currentState.startDate.add(Duration(days: event.weeks * 7));
      emit(currentState.copyWith(startDate: newStartDate));
   //   add(const FetchReservationsAndTransactions());
    }
  }

  void _onSelectSpecificDate(SelectSpecificDate event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(startDate: event.selectedDate));
    //  add(const FetchReservationsAndTransactions());
    }
  }

  Map<String, List<Reservation>> _groupReservationsByRoom(List<Reservation> reservations) {
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

  Map<String, List<RoomTransaction>> _groupRoomTransactionsByRoom(List<RoomTransaction> roomTransactions) {
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

  Reservation _updateReservationForMove(Reservation reservation, String newRoomNumber, DateTime newStartDate) {
    final originalDuration = reservation.checkOutDate.difference(reservation.stayDay);
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
    Reservation newReservation
  ) {
    final updatedReservations = List<Reservation>.from(currentState.reservations);
    final updatedReservationsByRoom = Map<String, List<Reservation>>.from(currentState.reservationsByRoom);

    // Remove from old room
    final oldRoomId = oldReservation.roomId.toString();
    updatedReservationsByRoom[oldRoomId]?.removeWhere((r) => r.id == newReservation.id);
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
    final index = updatedReservations.indexWhere((r) => r.id == newReservation.id);
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

  Reservation _updateReservationForCell(Reservation reservation, String roomNumber, DateTime date) {
    return reservation.copyWith(
      roomId: int.parse(roomNumber),
      stayDay: date,
      checkInDate: date,
    );
  }

  RoomCalendarLoaded _updateStateAfterReservationAdd(
    RoomCalendarLoaded currentState,
    Reservation newReservation
  ) {
    final updatedReservations = List<Reservation>.from(currentState.reservations);
    final updatedReservationsByRoom = Map<String, List<Reservation>>.from(currentState.reservationsByRoom);

    // Update or add to main list
    final existingIndex = updatedReservations.indexWhere((r) => r.id == newReservation.id);
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
    final roomExistingIndex = roomReservations.indexWhere((r) => r.id == newReservation.id);
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
}
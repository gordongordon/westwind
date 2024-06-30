import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';

// Events
abstract class RoomCalendarEvent extends Equatable {
  const RoomCalendarEvent();

  @override
  List<Object> get props => [];
}

class InitializeCalendar extends RoomCalendarEvent {}

class FetchReservations extends RoomCalendarEvent {}

class ChangeStartDate extends RoomCalendarEvent {
  final DateTime newStartDate;

  const ChangeStartDate(this.newStartDate);

  @override
  List<Object> get props => [newStartDate];
}

class ChangeDaysToShow extends RoomCalendarEvent {
  final int newDaysToShow;

  const ChangeDaysToShow(this.newDaysToShow);

  @override
  List<Object> get props => [newDaysToShow];
}

class MoveReservation extends RoomCalendarEvent {
  final Reservation reservation;
  final String newRoomNumber;
  final DateTime newStartDate;

  const MoveReservation({
    required this.reservation,
    required this.newRoomNumber,
    required this.newStartDate,
  });

  @override
  List<Object> get props => [reservation, newRoomNumber, newStartDate];
}

// States
abstract class RoomCalendarState extends Equatable {
  const RoomCalendarState();
  
  @override
  List<Object?> get props => [];
}

class RoomCalendarInitial extends RoomCalendarState {}

class RoomCalendarLoading extends RoomCalendarState {}

class RoomCalendarError extends RoomCalendarState {
  final String message;

  const RoomCalendarError({required this.message});

  @override
  List<Object> get props => [message];
}

class RoomCalendarLoaded extends RoomCalendarState {
  final List<String> roomTypes;
  final List<String> roomNumbers;
  final DateTime startDate;
  final int daysToShow;
  final List<Reservation> reservations;
  final Map<String, List<Reservation>> reservationsByRoom;

  const RoomCalendarLoaded({
    required this.roomTypes,
    required this.roomNumbers,
    required this.startDate,
    required this.daysToShow,
    required this.reservations,
    required this.reservationsByRoom,
  });

  @override
  List<Object?> get props => [
    roomTypes,
    roomNumbers,
    startDate,
    daysToShow,
    reservations,
    reservationsByRoom,
  ];

  RoomCalendarLoaded copyWith({
    List<String>? roomTypes,
    List<String>? roomNumbers,
    DateTime? startDate,
    int? daysToShow,
    List<Reservation>? reservations,
    Map<String, List<Reservation>>? reservationsByRoom,
  }) {
    return RoomCalendarLoaded(
      roomTypes: roomTypes ?? this.roomTypes,
      roomNumbers: roomNumbers ?? this.roomNumbers,
      startDate: startDate ?? this.startDate,
      daysToShow: daysToShow ?? this.daysToShow,
      reservations: reservations ?? this.reservations,
      reservationsByRoom: reservationsByRoom ?? this.reservationsByRoom,
    );
  }
}

// Bloc
class RoomCalendarBloc extends Bloc<RoomCalendarEvent, RoomCalendarState> {
  final ReservationRepository reservationRepository;
  final ReservationManageBloc reservationManageBloc;

  RoomCalendarBloc({
    required this.reservationRepository,
    required this.reservationManageBloc,
  }) : super(RoomCalendarInitial()) {
    on<InitializeCalendar>(_onInitializeCalendar);
    on<FetchReservations>(_onFetchReservations);
    on<ChangeStartDate>(_onChangeStartDate);
    on<ChangeDaysToShow>(_onChangeDaysToShow);
    on<MoveReservation>(_onMoveReservation);
  }

  void _onInitializeCalendar(InitializeCalendar event, Emitter<RoomCalendarState> emit) async {
    final List<String> roomTypes = ['Deluxe', 'Suite'];
    final List<String> roomNumbers = List.generate(67, (index) => (101 + index).toString());
    final DateTime startDate = DateTime.now();
    final int daysToShow = 7;
    
    emit(RoomCalendarLoaded(
      roomTypes: roomTypes,
      roomNumbers: roomNumbers,
      startDate: startDate,
      daysToShow: daysToShow,
      reservations: [],
      reservationsByRoom: {},
    ));

    add(FetchReservations());
  }

  void _onFetchReservations(FetchReservations event, Emitter<RoomCalendarState> emit) async {
    emit(RoomCalendarLoading());

    try {
      final result = await reservationRepository.list();
      result.fold(
        (failure) => emit(RoomCalendarError(message: failure.message)),
        (reservations) {
          final Map<String, List<Reservation>> reservationsByRoom = {};
          for (var reservation in reservations) {
            if (!reservationsByRoom.containsKey(reservation.roomId.toString())) {
              reservationsByRoom[reservation.roomId.toString()] = [];
            }
            reservationsByRoom[reservation.roomId.toString()]!.add(reservation);
          }

          if (state is RoomCalendarLoaded) {
            final loadedState = state as RoomCalendarLoaded;
            emit(loadedState.copyWith(
              reservations: reservations,
              reservationsByRoom: reservationsByRoom,
            ));
          } else {
            emit(RoomCalendarLoaded(
              roomTypes: ['Deluxe', 'Suite'],
              roomNumbers: List.generate(67, (index) => (101 + index).toString()),
              startDate: DateTime.now(),
              daysToShow: 7,
              reservations: reservations,
              reservationsByRoom: reservationsByRoom,
            ));
          }
        },
      );
    } catch (e) {
      emit(RoomCalendarError(message: 'Failed to fetch reservations: ${e.toString()}'));
    }
  }

  void _onChangeStartDate(ChangeStartDate event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(startDate: event.newStartDate));
    }
  }

  void _onChangeDaysToShow(ChangeDaysToShow event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(daysToShow: event.newDaysToShow));
    }
  }

void _onMoveReservation(MoveReservation event, Emitter<RoomCalendarState> emit) async {
  if (state is RoomCalendarLoaded) {
    final currentState = state as RoomCalendarLoaded;
    
    // Check for overlaps
    if (isOverlapping(event.reservation, event.newRoomNumber, event.newStartDate)) {
      emit(RoomCalendarError(message: "Cannot move reservation. It overlaps with an existing reservation."));
      return;
    }

    final existingReservation = currentState.reservations.firstWhere(
      (r) => r.id == event.reservation.id,
      orElse: () => event.reservation,
    );

    final guest = existingReservation.guest ?? event.reservation.guest;

    final duration = existingReservation.checkOutDate.difference(existingReservation.checkInDate);
    final updatedReservation = existingReservation.copyWith(
      roomId: int.parse(event.newRoomNumber),
      checkInDate: event.newStartDate,
      checkOutDate: event.newStartDate.add(duration),
      guest: guest,
    );

      // Use ReservationManageBloc to save the updated reservation
      reservationManageBloc.add(SaveReservation(reservation: updatedReservation));

      // Listen for the result of the save operation
      await for (final state in reservationManageBloc.stream) {
        if (state is ReservationManageStateSaveSuccess) {
          // Ensure the saved reservation has the guest information
          final savedReservation = state.reservation.copyWith(guest: guest);
          
          // Update was successful, update local state
          final updatedReservations = List<Reservation>.from(currentState.reservations);
          final updatedReservationsByRoom = Map<String, List<Reservation>>.from(currentState.reservationsByRoom);

          // Remove the reservation from its current room
          updatedReservationsByRoom[existingReservation.roomId.toString()]?.removeWhere((r) => r.id == updatedReservation.id);

          // Add the updated reservation to the new room
          if (!updatedReservationsByRoom.containsKey(event.newRoomNumber)) {
            updatedReservationsByRoom[event.newRoomNumber] = [];
          }
          updatedReservationsByRoom[event.newRoomNumber]!.add(savedReservation);

          // Update the reservation in the main list
          final index = updatedReservations.indexWhere((r) => r.id == updatedReservation.id);
          if (index != -1) {
            updatedReservations[index] = savedReservation;
          } else {
            updatedReservations.add(savedReservation);
          }

          emit(currentState.copyWith(
            reservations: updatedReservations,
            reservationsByRoom: updatedReservationsByRoom,
          ));

          break;
        } else if (state is ReservationManageStateFailure) {
          // Handle failure
          emit(RoomCalendarError(message: state.message));
          break;
        }
      }
    }
  }

bool isOverlapping(Reservation movedReservation, String newRoomNumber, DateTime newStartDate) {
  if (state is RoomCalendarLoaded) {
    final currentState = state as RoomCalendarLoaded;
    final reservationsInRoom = currentState.reservationsByRoom[newRoomNumber] ?? [];
    
    final newEndDate = newStartDate.add(movedReservation.checkOutDate.difference(movedReservation.checkInDate));

    return reservationsInRoom.any((existingReservation) {
      if (existingReservation.id == movedReservation.id) return false; // Don't compare with itself
      return (newStartDate.isBefore(existingReservation.checkOutDate) &&
          newEndDate.isAfter(existingReservation.checkInDate));
    });
  }
  return false;
}
}
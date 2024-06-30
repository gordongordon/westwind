import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';

// RoomCalendarEvent
@immutable
abstract class RoomCalendarEvent extends Equatable {
  const RoomCalendarEvent();

  @override
  List<Object> get props => [];
}

class InitializeCalendar extends RoomCalendarEvent {
  const InitializeCalendar();
}

class FetchReservations extends RoomCalendarEvent {
  const FetchReservations();
}

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

class AddReservationToCell extends RoomCalendarEvent {
  final Reservation reservation;
  final String roomNumber;
  final DateTime date;

  const AddReservationToCell({
    required this.reservation,
    required this.roomNumber,
    required this.date,
  });

  @override
  List<Object> get props => [reservation, roomNumber, date];
}

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
  //final List<String> roomTypes;
  final List<String> roomNumbers;
  final DateTime startDate;
  final int daysToShow;
  final List<Reservation> reservations;
  final Map<String, List<Reservation>> reservationsByRoom;

  const RoomCalendarLoaded({
    //   required this.roomTypes,
    required this.roomNumbers,
    required this.startDate,
    required this.daysToShow,
    required this.reservations,
    required this.reservationsByRoom,
  });

  @override
  List<Object?> get props => [
        //   roomTypes,
        roomNumbers,
        startDate,
        daysToShow,
        reservations,
        reservationsByRoom,
      ];

  RoomCalendarLoaded copyWith({
    // List<String>? roomTypes,
    List<String>? roomNumbers,
    DateTime? startDate,
    int? daysToShow,
    List<Reservation>? reservations,
    Map<String, List<Reservation>>? reservationsByRoom,
  }) {
    return RoomCalendarLoaded(
      //     roomTypes: roomTypes ?? this.roomTypes,
      roomNumbers: roomNumbers ?? this.roomNumbers,
      startDate: startDate ?? this.startDate,
      daysToShow: daysToShow ?? this.daysToShow,
      reservations: reservations ?? this.reservations,
      reservationsByRoom: reservationsByRoom ?? this.reservationsByRoom,
    );
  }
}

class RoomCalendarBloc extends Bloc<RoomCalendarEvent, RoomCalendarState> {
  final ReservationRepository reservationRepository;

  RoomCalendarBloc(
      {required this.reservationRepository,
      required ReservationManageBloc reservationManageBloc})
      : super(RoomCalendarInitial()) {
    on<InitializeCalendar>(_onInitializeCalendar);
    on<FetchReservations>(_onFetchReservations);
    on<ChangeStartDate>(_onChangeStartDate);
    on<ChangeDaysToShow>(_onChangeDaysToShow);
    on<MoveReservation>(_onMoveReservation);
    on<AddReservationToCell>(_onAddReservationToCell);
  }

  void _onInitializeCalendar(
      InitializeCalendar event, Emitter<RoomCalendarState> emit) async {
    //   final List<String> roomTypes = ['Deluxe', 'Suite'];
    final List<String> roomNumbers =
        List.generate(67, (index) => (101 + index).toString());
    final DateTime startDate = DateTime.now();
    final int daysToShow = 7;

    emit(RoomCalendarLoaded(
      //     roomTypes: roomTypes,
      roomNumbers: roomNumbers,
      startDate: startDate,
      daysToShow: daysToShow,
      reservations: [],
      reservationsByRoom: {},
    ));

    add(FetchReservations());
  }

  void _onFetchReservations(
      FetchReservations event, Emitter<RoomCalendarState> emit) async {
    emit(RoomCalendarLoading());

    try {
      final result = await reservationRepository.list();
      result.fold(
        (failure) => emit(RoomCalendarError(message: failure.message)),
        (reservations) {
          final Map<String, List<Reservation>> reservationsByRoom = {};
          for (var reservation in reservations) {
            final roomId = reservation.roomId.toString();
            if (!reservationsByRoom.containsKey(roomId)) {
              reservationsByRoom[roomId] = [];
            }
            reservationsByRoom[roomId]!.add(reservation);
          }

          emit(RoomCalendarLoaded(
            //  roomTypes: ['Deluxe', 'Suite'],
            roomNumbers: List.generate(67, (index) => (101 + index).toString()),
            startDate: DateTime.now(),
            daysToShow: 7,
            reservations: reservations,
            reservationsByRoom: reservationsByRoom,
          ));
        },
      );
    } catch (e) {
      emit(RoomCalendarError(
          message: 'Failed to fetch reservations: ${e.toString()}'));
    }
  }

  void _onChangeStartDate(
      ChangeStartDate event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(startDate: event.newStartDate));
    }
  }

  void _onChangeDaysToShow(
      ChangeDaysToShow event, Emitter<RoomCalendarState> emit) {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;
      emit(currentState.copyWith(daysToShow: event.newDaysToShow));
    }
  }

  Future<void> _onMoveReservation(
      MoveReservation event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;

      // Calculate the duration of the original reservation
      final originalDuration = event.reservation.checkOutDate
          .difference(event.reservation.checkInDate);

      // Create the updated reservation
      final updatedReservation = event.reservation.copyWith(
        roomId: int.parse(event.newRoomNumber),
        checkInDate: event.newStartDate,
        checkOutDate: event.newStartDate.add(originalDuration),
      );

      // Save the updated reservation to the repository
      final saveResult = await reservationRepository.save(updatedReservation);

      saveResult.fold(
        (failure) {
          emit(RoomCalendarError(
              message: "Failed to move reservation: ${failure.message}"));
        },
        (savedReservation) {
          final updatedReservations =
              List<Reservation>.from(currentState.reservations);
          final updatedReservationsByRoom = Map<String, List<Reservation>>.from(
              currentState.reservationsByRoom);

          // Remove the reservation from its old room
          final oldRoomId = event.reservation.roomId.toString();
          updatedReservationsByRoom[oldRoomId]
              ?.removeWhere((r) => r.id == savedReservation.id);
          if (updatedReservationsByRoom[oldRoomId]?.isEmpty ?? false) {
            updatedReservationsByRoom.remove(oldRoomId);
          }

          // Add the reservation to its new room
          if (!updatedReservationsByRoom.containsKey(event.newRoomNumber)) {
            updatedReservationsByRoom[event.newRoomNumber] = [];
          }
          updatedReservationsByRoom[event.newRoomNumber]!.add(savedReservation);

          // Update the reservation in the main list
          final index = updatedReservations
              .indexWhere((r) => r.id == savedReservation.id);
          if (index != -1) {
            updatedReservations[index] = savedReservation;
          } else {
            updatedReservations.add(savedReservation);
          }

          emit(currentState.copyWith(
            reservations: updatedReservations,
            reservationsByRoom: updatedReservationsByRoom,
          ));

          // Fetch reservations again to ensure we have the latest data
          add(FetchReservations());
        },
      );
    }
  }

  Future<void> _onAddReservationToCell(
      AddReservationToCell event, Emitter<RoomCalendarState> emit) async {
    if (state is RoomCalendarLoaded) {
      final currentState = state as RoomCalendarLoaded;

      // Update the reservation
      final updatedReservation = event.reservation.copyWith(
        roomId: int.parse(event.roomNumber),
        checkInDate: event.date,
      );

      // Save the updated reservation to the repository
      final saveResult = await reservationRepository.save(updatedReservation);

      saveResult.fold(
        (failure) {
          emit(RoomCalendarError(
              message: "Failed to save reservation: ${failure.message}"));
        },
        (savedReservation) {
          final updatedReservations =
              List<Reservation>.from(currentState.reservations);
          final updatedReservationsByRoom = Map<String, List<Reservation>>.from(
              currentState.reservationsByRoom);

          // Check if the reservation already exists in the list (by ID)
          final existingIndex = updatedReservations
              .indexWhere((r) => r.id == savedReservation.id);
          if (existingIndex != -1) {
            // If it exists, update it
            updatedReservations[existingIndex] = savedReservation;
          } else {
            // If it doesn't exist, add it
            updatedReservations.add(savedReservation);
          }

          // Update the reservations for the specific room
          if (!updatedReservationsByRoom.containsKey(event.roomNumber)) {
            updatedReservationsByRoom[event.roomNumber] = [];
          }
          final roomReservations = updatedReservationsByRoom[event.roomNumber]!;
          final roomExistingIndex =
              roomReservations.indexWhere((r) => r.id == savedReservation.id);
          if (roomExistingIndex != -1) {
            roomReservations[roomExistingIndex] = savedReservation;
          } else {
            roomReservations.add(savedReservation);
          }

          emit(currentState.copyWith(
            reservations: updatedReservations,
            reservationsByRoom: updatedReservationsByRoom,
          ));

          // Fetch reservations again to ensure we have the latest data
          add(FetchReservations());
        },
      );
    }
  }
/*
  bool _isOverlapping(Reservation newReservation, String roomNumber,
      DateTime date, RoomCalendarLoaded state) {
    final existingReservations = state.reservationsByRoom[roomNumber] ?? [];

    return existingReservations.any((existingReservation) {
      // Allow multiple reservations on the same day, but prevent exact duplicates
      return newReservation.checkInDate == existingReservation.checkInDate &&
          newReservation.checkOutDate == existingReservation.checkOutDate;
    });
  }
  */
}


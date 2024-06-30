part of 'room_calendar_bloc.dart';

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
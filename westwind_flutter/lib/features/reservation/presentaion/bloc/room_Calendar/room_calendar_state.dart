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
  final List<RoomTransaction> roomTransactions;
  final Map<String, List<RoomTransaction>> roomTransactionsByRoom;

  const RoomCalendarLoaded({
    required this.roomTypes,
    required this.roomNumbers,
    required this.startDate,
    required this.daysToShow,
    required this.reservations,
    required this.reservationsByRoom,
    required this.roomTransactions,
    required this.roomTransactionsByRoom,
  });

  @override
  List<Object?> get props => [
    roomTypes,
    roomNumbers,
    startDate,
    daysToShow,
    reservations,
    reservationsByRoom,
    roomTransactions,
    roomTransactionsByRoom,
  ];

  RoomCalendarLoaded copyWith({
    List<String>? roomTypes,
    List<String>? roomNumbers,
    DateTime? startDate,
    int? daysToShow,
    List<Reservation>? reservations,
    Map<String, List<Reservation>>? reservationsByRoom,
    List<RoomTransaction>? roomTransactions,
    Map<String, List<RoomTransaction>>? roomTransactionsByRoom,
  }) {
    return RoomCalendarLoaded(
      roomTypes: roomTypes ?? this.roomTypes,
      roomNumbers: roomNumbers ?? this.roomNumbers,
      startDate: startDate ?? this.startDate,
      daysToShow: daysToShow ?? this.daysToShow,
      reservations: reservations ?? this.reservations,
      reservationsByRoom: reservationsByRoom ?? this.reservationsByRoom,
      roomTransactions: roomTransactions ?? this.roomTransactions,
      roomTransactionsByRoom: roomTransactionsByRoom ?? this.roomTransactionsByRoom,
    );
  }
}
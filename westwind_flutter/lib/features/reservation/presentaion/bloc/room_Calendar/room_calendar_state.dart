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
  final List<String> roomStatus;
  final DateTime startDate;
  final int daysToShow;
  final List<Reservation> reservations;
  final Map<String, List<Reservation>> reservationsByRoom;
  final List<RoomTransaction> roomTransactions;
  final Map<String, List<RoomTransaction>> roomTransactionsByRoom;
  final List<RoomGuest> roomGuests;
  final Map<String, List<RoomGuest>> roomGuestsByRoom;

  const RoomCalendarLoaded({
    required this.roomTypes,
    required this.roomNumbers,
    required this.roomStatus,
    required this.startDate,
    required this.daysToShow,
    required this.reservations,
    required this.reservationsByRoom,
    required this.roomTransactions,
    required this.roomTransactionsByRoom,
    required this.roomGuests,
    required this.roomGuestsByRoom,
  });

  @override
  List<Object?> get props => [
    roomTypes,
    roomNumbers,
    roomStatus,
    startDate,
    daysToShow,
    reservations,
    reservationsByRoom,
    roomTransactions,
    roomTransactionsByRoom,
    roomGuests,
    roomGuestsByRoom,
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
    List<RoomGuest>? roomGuests,
    Map<String, List<RoomGuest>>? roomGuestsByRoom,
  }) {
    return RoomCalendarLoaded(
      roomTypes: roomTypes ?? this.roomTypes,
      roomNumbers: roomNumbers ?? this.roomNumbers,
      roomStatus: roomStatus ?? this.roomStatus,
      startDate: startDate ?? this.startDate,
      daysToShow: daysToShow ?? this.daysToShow,
      reservations: reservations ?? this.reservations,
      reservationsByRoom: reservationsByRoom ?? this.reservationsByRoom,
      roomTransactions: roomTransactions ?? this.roomTransactions,
      roomTransactionsByRoom: roomTransactionsByRoom ?? this.roomTransactionsByRoom,
      roomGuests: roomGuests ?? this.roomGuests,
      roomGuestsByRoom: roomGuestsByRoom ?? this.roomGuestsByRoom,
    );
  }
}
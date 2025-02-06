part of 'room_calendar_bloc.dart';

@immutable
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
  final List<String> roomTypes;         // List of room types (e.g., "Standard", "Deluxe")
  final List<String> roomNumbers;       // List of room numbers (e.g., "101", "102")
  final List<String> roomStatus;        // List of room status (e.g., "Available", "Unavailable")
  final DateTime startDate;             // Current start date being displayed
  final int daysToShow;                 // Number of days to show in the calendar
  
  // All data lists
  final List<Reservation> reservations;
  final List<RoomTransaction> roomTransactions;
  final List<RoomGuest> roomGuests;
  
  // Data grouped by room for efficient access
  final Map<String, List<Reservation>> reservationsByRoom;
  final Map<String, List<RoomTransaction>> roomTransactionsByRoom;
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

  // Creates a copy of the current state with optional updated fields
  RoomCalendarLoaded copyWith({
    List<String>? roomTypes,
    List<String>? roomNumbers,
    List<String>? roomStatus,
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

  // Helper methods for accessing and manipulating data
  List<dynamic> getItemsForDateAndRoom(String roomNumber, DateTime date) {
    final List<dynamic> items = [];

    // Add reservations for this room and date
    final roomReservations = reservationsByRoom[roomNumber] ?? [];
    items.addAll(roomReservations.where((reservation) =>
        reservation.stayDay.isSameDay(date)));

    // Add room transactions for this room and date
    final roomTrans = roomTransactionsByRoom[roomNumber] ?? [];
    items.addAll(roomTrans.where((transaction) =>
        transaction.stayDay.isSameDay(date)));

    // Add room guests for this room and date
    final guests = roomGuestsByRoom[roomNumber] ?? [];
    items.addAll(guests.where((guest) =>
        guest.stayDay.isSameDay(date)));

    return items;
  }

  bool isDateAvailable(String roomNumber, DateTime date) {
    return getItemsForDateAndRoom(roomNumber, date).isEmpty;
  }

  bool isRoomAvailable(String roomNumber) {
    return roomStatus[roomNumbers.indexOf(roomNumber)] != 'Unavailable';
  }

  bool canAcceptReservation(String roomNumber, DateTime date) {
    return isDateAvailable(roomNumber, date) && isRoomAvailable(roomNumber);
  }

  List<String> getAvailableRooms(DateTime date) {
    return roomNumbers.where((roomNumber) => 
      canAcceptReservation(roomNumber, date)).toList();
  }

  int getOccupancyRate(DateTime date) {
    int occupied = 0;
    for (String roomNumber in roomNumbers) {
      if (!isDateAvailable(roomNumber, date)) {
        occupied++;
      }
    }
    return ((occupied / roomNumbers.length) * 100).round();
  }

  double getRevenue(DateTime date) {
    double total = 0;
    for (var transaction in roomTransactions) {
      if (transaction.stayDay.isSameDay(date)) {
        total += transaction.amount;
      }
    }
    return total;
  }
}
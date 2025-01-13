part of 'room_calendar_bloc.dart';

@immutable
abstract class RoomCalendarEvent extends Equatable {
  const RoomCalendarEvent();

  @override
  List<Object> get props => [];
}

class InitializeCalendar extends RoomCalendarEvent {
  const InitializeCalendar();
}

class FetchReservationsAndTransactions extends RoomCalendarEvent {
  final DateTime startDate;

  const FetchReservationsAndTransactions(this.startDate);
    @override
  List<Object> get props => [startDate];
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

class NavigateCalendarDays extends RoomCalendarEvent {
  final int days;

  const NavigateCalendarDays(this.days);

  @override
  List<Object> get props => [days];
}

class NavigateCalendarWeeks extends RoomCalendarEvent {
  final int weeks;

  const NavigateCalendarWeeks(this.weeks);

  @override
  List<Object> get props => [weeks];
}

class SelectSpecificDate extends RoomCalendarEvent {
  final DateTime selectedDate;

  const SelectSpecificDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class ToggleRoomStatus extends RoomCalendarEvent {
  final int roomId;

  const ToggleRoomStatus(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class MoveRoomGuest extends RoomCalendarEvent {
  final RoomGuest roomGuest;
  final String newRoomNumber;
  final DateTime newStayDate;

  const MoveRoomGuest({
    required this.roomGuest,
    required this.newRoomNumber,
    required this.newStayDate,
  });

  @override
  List<Object> get props => [roomGuest, newRoomNumber, newStayDate];
}


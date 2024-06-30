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
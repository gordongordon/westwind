part of 'reservation_manage_bloc.dart';

@immutable
sealed class ReservationManageEvent {}

final class SaveReservation extends ReservationManageEvent {
  final Reservation reservation;

  SaveReservation( {required this.reservation } );
}

final class DeleteReservation extends ReservationManageEvent {
  final int id;
  
  DeleteReservation( { required this.id } );
}

final class RetrieveReservation extends ReservationManageEvent {
  final int id;

  RetrieveReservation( { required this.id } );
}

final class RetrieveGuestForReservation extends ReservationManageEvent {
  final int id;

  RetrieveGuestForReservation( {required this.id });
}

final class RetrieveGuestByPhoneForReservation extends ReservationManageEvent {
  final String phone;

  RetrieveGuestByPhoneForReservation( {required this.phone });
}

final class CheckInReservation extends ReservationManageEvent {
  final int id;

  CheckInReservation( { required this.id} );
}
part of 'reservation_manage_bloc.dart';

@immutable
sealed class ReservationManageState {}

final class ReservationManageStateInitial extends ReservationManageState {}

final class ReservationManageStateLoading extends ReservationManageState {}

final class ReservationManageStateRetrieveSuccess extends ReservationManageState {
    final Reservation reservation;
   
    ReservationManageStateRetrieveSuccess( this.reservation );
}

final class ReservationManageStateSaveSuccess extends ReservationManageState {
    final Reservation reservation;

    ReservationManageStateSaveSuccess( this.reservation );
}

final class ReservationManageStateDeleteSuccess extends ReservationManageState {}

final class ReservationManageStateFailure extends ReservationManageState {
  final String message;

   ReservationManageStateFailure( this.message );
}

final class ReservationManageStateRetrieveGuestSuccess extends ReservationManageState {
    final Guest guest;

    ReservationManageStateRetrieveGuestSuccess( this.guest  );
}

final class ReservationManageStateCheckInSuccess extends ReservationManageState {
    
}



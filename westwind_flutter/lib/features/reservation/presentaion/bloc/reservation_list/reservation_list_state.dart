part of 'reservation_list_bloc.dart';

@immutable
sealed class ReservationListState {
  const ReservationListState();
}

final class ReservationListStateInitial extends ReservationListState {}

final class ReservationListStateLoading extends ReservationListState {}

final class ReservationListStateLoaded extends ReservationListState {
  final List<Reservation> reservations;
  
  const ReservationListStateLoaded( {required this.reservations} );
}

final class ReservationListStateFailure extends ReservationListState {
  final String message;

  const ReservationListStateFailure( {required this.message });

}


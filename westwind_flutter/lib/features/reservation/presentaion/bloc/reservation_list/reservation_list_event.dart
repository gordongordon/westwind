part of 'reservation_list_bloc.dart';

@immutable
sealed class ReservationListEvent {}

final class FetchReservationsEvent extends ReservationListEvent {}
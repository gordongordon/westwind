part of 'room_guest_list_bloc.dart';

@immutable
sealed class RoomGuestListState {}

final class RoomGuestListStateInitial extends RoomGuestListState {}

final class RoomGuestListStateLoading extends RoomGuestListState {}

final class RoomGuestListStateLoaded extends RoomGuestListState {
  final List<RoomGuest> roomGuests;

  RoomGuestListStateLoaded( this.roomGuests );
}

final class RoomGuestListStateFailure extends RoomGuestListState {
   final String message;

   RoomGuestListStateFailure( this.message );
}

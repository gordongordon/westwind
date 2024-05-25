part of 'room_guest_manage_bloc.dart';

@immutable
sealed class RoomGuestManageEvent {}

class RetrieveRoomGuest extends RoomGuestManageEvent {
   final int id;

   RetrieveRoomGuest( this.id );

}

class DeleteRoomGuest extends RoomGuestManageEvent{
  final int id;
  DeleteRoomGuest( this.id );
}

//! May be by Reservetion Id only, because, have to create a reservationf irst. 
class CheckInRoomGuest extends RoomGuestManageEvent {
  final Reservation reservation;

  CheckInRoomGuest( this.reservation );
}

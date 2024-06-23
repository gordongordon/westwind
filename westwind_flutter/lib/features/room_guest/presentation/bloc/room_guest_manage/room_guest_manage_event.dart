part of 'room_guest_manage_bloc.dart';

@immutable
sealed class RoomGuestManageEvent {}


class SaveRoomGuest extends RoomGuestManageEvent {
   final RoomGuest roomGuest;

   SaveRoomGuest( this.roomGuest );
}


class RetrieveRoomGuest extends RoomGuestManageEvent {
  final int id;

  RetrieveRoomGuest(this.id);
}

class DeleteRoomGuest extends RoomGuestManageEvent {
  final int id;
  DeleteRoomGuest(this.id);
}

class ChargeRoomGuest extends RoomGuestManageEvent {
  final int id;
  ChargeRoomGuest(this.id);
}

class ExtendStayDayRoomGuest extends RoomGuestManageEvent {
  final int id;
  ExtendStayDayRoomGuest(this.id);
}

//! May be by Reservetion Id only, because, have to create a reservationf irst.
class CheckInRoomGuest extends RoomGuestManageEvent {
  final Reservation reservation;

  CheckInRoomGuest(this.reservation);
}

class CalculateRateRoomGuest extends RoomGuestManageEvent {
  final int id;
  
  CalculateRateRoomGuest(this.id);
}

class ChargeAndExtendStayDay extends RoomGuestManageEvent {
  final int id;

  ChargeAndExtendStayDay({required this.id});
}

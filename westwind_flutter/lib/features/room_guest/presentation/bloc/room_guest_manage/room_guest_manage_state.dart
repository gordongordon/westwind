part of 'room_guest_manage_bloc.dart';

@immutable
sealed class RoomGuestManageState {}

final class RoomGuestManageStateInitial extends RoomGuestManageState {}

final class RoomGuestManageStateLoading extends RoomGuestManageState {} 

final class RoomGuestManageStateSaveSuccess extends RoomGuestManageState {
   final RoomGuest roomGuest;

   RoomGuestManageStateSaveSuccess( this.roomGuest );
}

final class RoomGuestManageStateRetrieveSuccess extends RoomGuestManageState {
      final RoomGuest roomGuest;
      RoomGuestManageStateRetrieveSuccess( this.roomGuest );
}

final class RoomGuestManageStateCheckInSuccess extends RoomGuestManageState {
  final RoomGuest roomGuest;

  RoomGuestManageStateCheckInSuccess( this.roomGuest );
}


final class RoomGuestManageStateCalculateRateSuccess extends RoomGuestManageState {
  final RoomGuest roomGuest;

  RoomGuestManageStateCalculateRateSuccess( this.roomGuest );
}


final class RoomGuestManageStateDeleteSuccess extends RoomGuestManageState {}

final class RoomGuestManageStateChargeSuccess extends RoomGuestManageState {}

final class RoomGuestManageStateFailure extends RoomGuestManageState {
  final String message;

  RoomGuestManageStateFailure( this.message );
}

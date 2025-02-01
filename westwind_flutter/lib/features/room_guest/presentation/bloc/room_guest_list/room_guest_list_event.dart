part of 'room_guest_list_bloc.dart';

@immutable
sealed class RoomGuestListEvent {}

class FetchRoomGuestsEvent extends RoomGuestListEvent {}
class FetchRoomGuestsButCOEvent extends RoomGuestListEvent {}

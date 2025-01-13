part of 'room_toggle_bloc.dart';

@immutable
sealed class RoomToggleEvent {}

class ToggleRoomStatus extends RoomToggleEvent {
 //  int id;


  final int id;

    ToggleRoomStatus(this.id);
}

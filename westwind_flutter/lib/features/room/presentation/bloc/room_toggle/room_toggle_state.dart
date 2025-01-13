part of 'room_toggle_bloc.dart';

@immutable
sealed class RoomToggleState {}

final class RoomToggleStateInitial extends RoomToggleState {}

final class RoomToggleStateLoading extends RoomToggleState  {}

final class RoomToggleStateLoaded extends RoomToggleState  {
  final Room room;

  RoomToggleStateLoaded( this.room );
}

final class RoomToggleStateFailure extends RoomToggleState  {
   final String message;

   RoomToggleStateFailure( this.message );
}

part of 'room_transaction_bloc.dart';

@immutable
sealed class RoomTransactionEvent {}

class FetchRoomTransactionsEvent extends RoomTransactionEvent {}

class DeleteRoomTransactionEvent extends RoomTransactionEvent {
  final int id;

   DeleteRoomTransactionEvent({required this.id});
}

class RetrieveRoomTransactionEvent extends RoomTransactionEvent {
  final int id;

   RetrieveRoomTransactionEvent({required this.id});
}

class CreateRoomTransactionEvent extends RoomTransactionEvent {
  final RoomTransaction roomTransaction;

  CreateRoomTransactionEvent({required this.roomTransaction});
}

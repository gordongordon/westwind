part of 'room_transaction_list_bloc.dart';

@immutable
sealed class RoomTransactionListEvent {}

class FetchRoomTransactionsListEvent extends RoomTransactionListEvent {}

class DeleteRoomTransactionListEvent extends RoomTransactionListEvent {
  final int id;

   DeleteRoomTransactionListEvent({required this.id});
}

class RetrieveRoomTransactionListEvent extends RoomTransactionListEvent {
  final int id;

   RetrieveRoomTransactionListEvent({required this.id});
}

class CreateRoomTransactionListEvent extends RoomTransactionListEvent {
  final RoomTransaction roomTransaction;

  CreateRoomTransactionListEvent({required this.roomTransaction});
}

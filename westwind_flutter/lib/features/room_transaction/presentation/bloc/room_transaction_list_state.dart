part of 'room_transaction_list_bloc.dart';

@immutable
sealed class RoomTransactionListState {}

class RoomTransactionListStateInitial extends RoomTransactionListState {}

class RoomTransactionListStateLoading extends RoomTransactionListState {}

class RoomTransactionListStateLoaded extends RoomTransactionListState {
  final List<RoomTransaction> roomTransactions;

  RoomTransactionListStateLoaded({required this.roomTransactions});
}

class RoomTransactionListStateFailure extends RoomTransactionListState {
  final String message;

  RoomTransactionListStateFailure({required this.message});
}

class RoomTransactionListStateDeleted extends RoomTransactionListState {
  final int id;

  RoomTransactionListStateDeleted({required this.id});
}

class RoomTransactionListStateRetrieved extends RoomTransactionListState {
  final RoomTransaction roomTransaction;

  RoomTransactionListStateRetrieved({required this.roomTransaction});
}

class RoomTransactionListStateCreated extends RoomTransactionListState {
  final RoomTransaction roomTransaction;

  RoomTransactionListStateCreated({required this.roomTransaction});
}

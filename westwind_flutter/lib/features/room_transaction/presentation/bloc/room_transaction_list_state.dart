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

class RoomTransactionListStateDeletedSuccess extends RoomTransactionListState {
  final int id;

  RoomTransactionListStateDeletedSuccess({required this.id});
}

class RoomTransactionListStateRetrievedSuccess extends RoomTransactionListState {
  final RoomTransaction roomTransaction;

  RoomTransactionListStateRetrievedSuccess({required this.roomTransaction});
}

class RoomTransactionListStateCreatedSuccess extends RoomTransactionListState {
  final RoomTransaction roomTransaction;

  RoomTransactionListStateCreatedSuccess({required this.roomTransaction});
}

part of 'room_transaction_bloc.dart';

@immutable
sealed class RoomTransactionState {}

class RoomTransactionListStateInitial extends RoomTransactionState {}

class RoomTransactionListStateLoading extends RoomTransactionState {}

class RoomTransactionListStateLoaded extends RoomTransactionState {
  final List<RoomTransaction> roomTransactions;

  RoomTransactionListStateLoaded({required this.roomTransactions});
}

class RoomTransactionStateFailure extends RoomTransactionState {
  final String message;

  RoomTransactionStateFailure({required this.message});
}

class RoomTransactionStateDeletedSuccess extends RoomTransactionState {
  final int id;

  RoomTransactionStateDeletedSuccess({required this.id});
}

class RoomTransactionStateRetrievedSuccess extends RoomTransactionState {
  final RoomTransaction roomTransaction;

  RoomTransactionStateRetrievedSuccess({required this.roomTransaction});
}

class RoomTransactionStateCreatedSuccess extends RoomTransactionState {
  final RoomTransaction roomTransaction;

  RoomTransactionStateCreatedSuccess({required this.roomTransaction});
}

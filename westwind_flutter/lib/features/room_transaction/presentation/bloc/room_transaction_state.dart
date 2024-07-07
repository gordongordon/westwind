part of 'room_transaction_bloc.dart';

@immutable
sealed class RoomTransactionState {}

class RoomTransactionStateInitial extends RoomTransactionState {}

class RoomTransactionStateLoading extends RoomTransactionState {}

class RoomTransactionStateLoaded extends RoomTransactionState {
  final List<RoomTransaction> roomTransactions;

  RoomTransactionStateLoaded({required this.roomTransactions});
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

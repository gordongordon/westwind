import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_create_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

// Events
abstract class RoomGuestTransactionsEvent extends Equatable {
  const RoomGuestTransactionsEvent();

  @override
  List<Object> get props => [];
}

class FetchRoomGuestTransactions extends RoomGuestTransactionsEvent {
  final int roomGuestId;

  const FetchRoomGuestTransactions(this.roomGuestId);

  @override
  List<Object> get props => [roomGuestId];
}

class CreateRoomTransaction extends RoomGuestTransactionsEvent {
  final RoomTransaction transaction;

  const CreateRoomTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}

// States
abstract class RoomGuestTransactionsState extends Equatable {
  const RoomGuestTransactionsState();

  @override
  List<Object> get props => [];
}

class RoomGuestTransactionsInitial extends RoomGuestTransactionsState {}

class RoomGuestTransactionsLoading extends RoomGuestTransactionsState {}

class RoomGuestTransactionsLoaded extends RoomGuestTransactionsState {
  final List<RoomTransaction> transactions;

  const RoomGuestTransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class RoomGuestTransactionsError extends RoomGuestTransactionsState {
  final String message;

  const RoomGuestTransactionsError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class RoomGuestTransactionsBloc extends Bloc<RoomGuestTransactionsEvent, RoomGuestTransactionsState> {
  final RoomTransactionRepository roomTransactionRepository;
  final CreateRoomTransactionUseCase createRoomTransactionUseCase;

  RoomGuestTransactionsBloc({
    required this.roomTransactionRepository,
    required this.createRoomTransactionUseCase,
  }) : super(RoomGuestTransactionsInitial()) {
    on<FetchRoomGuestTransactions>(_onFetchRoomGuestTransactions);
    on<CreateRoomTransaction>(_onCreateRoomTransaction);
  }

  Future<void> _onFetchRoomGuestTransactions(
    FetchRoomGuestTransactions event,
    Emitter<RoomGuestTransactionsState> emit,
  ) async {
    emit(RoomGuestTransactionsLoading());
    try {
      final transactions = await roomTransactionRepository.getTransactionsForRoomGuest(event.roomGuestId);
   //      final transactions = await roomTransactionRepository.list();

      emit(RoomGuestTransactionsLoaded(transactions.foldResult()));
    } catch (e) {
      emit(RoomGuestTransactionsError('Failed to fetch transactions: $e'));
    }
  }

  Future<void> _onCreateRoomTransaction(
    CreateRoomTransaction event,
    Emitter<RoomGuestTransactionsState> emit,
  ) async {
    emit(RoomGuestTransactionsLoading());
    try {
      final result = await createRoomTransactionUseCase(CreateRoomTransactionParams(roomTransaction: event.transaction));
      result.fold(
        (failure) => emit(RoomGuestTransactionsError(failure.message)),
        (newTransaction) {
          if (state is RoomGuestTransactionsLoaded) {
            final currentTransactions = (state as RoomGuestTransactionsLoaded).transactions;
            emit(RoomGuestTransactionsLoaded([...currentTransactions, newTransaction]));
          } else {
            emit(RoomGuestTransactionsLoaded([newTransaction]));
          }
        },
      );
    } catch (e) {
      emit(RoomGuestTransactionsError('Failed to create transaction: $e'));
    }
  }
}
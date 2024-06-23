import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_Transaction_list_usercase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_create_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_delete_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_retrieve_usecase.dart';

part 'room_transaction_list_event.dart';
part 'room_transaction_list_state.dart';

class RoomTransactionListBloc
    extends Bloc<RoomTransactionListEvent, RoomTransactionListState> {
  final ListRoomTransactionsUseCase listRoomTransactions;
  final DeleteRoomTransactionUseCase deleteRoomTransaction;
  final RetrieveRoomTransactionUseCase retrieveRoomTransaction;
  final CreateRoomTransactionUseCase createRoomTransaction;

  RoomTransactionListBloc({
    required this.listRoomTransactions,
    required this.deleteRoomTransaction,
    required this.retrieveRoomTransaction,
    required this.createRoomTransaction,
  }) : super(RoomTransactionListStateInitial()) {
    on<FetchRoomTransactionsListEvent>(_onFetchRoomTransactions);
    on<DeleteRoomTransactionListEvent>((_onDeleteRoomTransaction));
    on<RetrieveRoomTransactionListEvent>((_onRetrieveRoomTransaction));
    on<CreateRoomTransactionListEvent>((_onCreateRoomTransaction));
  }

  Future<void> _onFetchRoomTransactions(RoomTransactionListEvent event,
      Emitter<RoomTransactionListState> emit) async {
    emit(RoomTransactionListStateLoading());
    final result = await listRoomTransactions.call(NoParams());
    result.fold(
        (l) => emit(RoomTransactionListStateFailure(message: l.message)), (r) {
      emit(RoomTransactionListStateLoaded(roomTransactions: r));
    });
  }

  void _onDeleteRoomTransaction(DeleteRoomTransactionListEvent event,
      Emitter<RoomTransactionListState> emit) async {
    emit(RoomTransactionListStateLoading());
    final result = await deleteRoomTransaction
        .call(DeleteRoomTransactionParams(id: event.id));
    result.fold(
        (l) => emit(RoomTransactionListStateFailure(message: l.message)), (r) {
      if (r) {
        emit(RoomTransactionListStateDeletedSuccess(id: event.id));
      } else {
        // emit(RoomTransactionStateFailure( Failure( "Failed to delete room transaction" ) ));
      }
    });
  }

  void _onRetrieveRoomTransaction(RetrieveRoomTransactionListEvent event,
      Emitter<RoomTransactionListState> emit) async {
    emit(RoomTransactionListStateLoading());
    final result = await retrieveRoomTransaction
        .call(RetrieveRoomTransactionParams(id: event.id));
    result.fold(
        (l) => emit(RoomTransactionListStateFailure(message: l.message)), (r) {
      emit(RoomTransactionListStateRetrievedSuccess(roomTransaction: r));
    });
  }

  void _onCreateRoomTransaction(CreateRoomTransactionListEvent event,
      Emitter<RoomTransactionListState> emit) async {
    emit(RoomTransactionListStateLoading());
    final result = await createRoomTransaction.call(
        CreateRoomTransactionParams(roomTransaction: event.roomTransaction));
    result.fold(
        (l) => emit(RoomTransactionListStateFailure(message: l.message)), (r) {
      emit(RoomTransactionListStateCreatedSuccess(roomTransaction: r));
    });
  }
}

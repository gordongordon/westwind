import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/retrieve_room_guest.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_Transaction_list_usercase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_create_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_delete_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_retrieve_usecase.dart';

part 'room_transaction_event.dart';
part 'room_transaction_state.dart';

class RoomTransactionBloc
    extends Bloc<RoomTransactionEvent, RoomTransactionState> {
  final ListRoomTransactionsUseCase listRoomTransactions;
  final DeleteRoomTransactionUseCase deleteRoomTransaction;
  final RetrieveRoomTransactionUseCase retrieveRoomTransaction;
  final CreateRoomTransactionUseCase createRoomTransaction;
  final RetrieveRoomGuestUseCase retrieveRoomGuest;

  RoomTransactionBloc({
    required this.listRoomTransactions,
    required this.deleteRoomTransaction,
    required this.retrieveRoomTransaction,
    required this.createRoomTransaction,
    required this.retrieveRoomGuest,
  }) : super(RoomTransactionListStateInitial()) {
    on<FetchRoomTransactionsEvent>(_onFetchRoomTransactions);
    on<DeleteRoomTransactionEvent>((_onDeleteRoomTransaction));
    on<RetrieveRoomTransactionEvent>((_onRetrieveRoomTransaction));
    on<CreateRoomTransactionEvent>((_onCreateRoomTransaction));
    on<RetrieveRoomGuestEvent>(
        (_onRetrieveRoomGuest));
  }

  Future<void> _onFetchRoomTransactions(RoomTransactionEvent event,
      Emitter<RoomTransactionState> emit) async {
    emit(RoomTransactionListStateLoading());


    final result = await listRoomTransactions.call(NoParams());
    result.fold(
        (l) => emit(RoomTransactionStateFailure(message: l.message)), (r) {
      emit(RoomTransactionListStateLoaded(roomTransactions: r));
    });
  }

  void _onDeleteRoomTransaction(DeleteRoomTransactionEvent event,
      Emitter<RoomTransactionState> emit) async {
    emit(RoomTransactionListStateLoading());
   await Future.delayed(Duration(seconds: 1));

    final result = await deleteRoomTransaction
        .call(DeleteRoomTransactionParams(id: event.id));
    result.fold(
        (l) => emit(RoomTransactionStateFailure(message: l.message)), (r) {
      if (r) {
        emit(RoomTransactionStateDeletedSuccess(id: event.id));
      } else {
        // emit(RoomTransactionStateFailure( Failure( "Failed to delete room transaction" ) ));
      }
    });
  }

  void _onRetrieveRoomTransaction(RetrieveRoomTransactionEvent event,
      Emitter<RoomTransactionState> emit) async {
    emit(RoomTransactionListStateLoading());
   await Future.delayed(Duration(seconds: 1));

    final result = await retrieveRoomTransaction
        .call(RetrieveRoomTransactionParams(id: event.id));
    result.fold(
        (l) => emit(RoomTransactionStateFailure(message: l.message)), (r) {
      emit(RoomTransactionStateRetrievedSuccess(roomTransaction: r));
    });
  }

  void _onCreateRoomTransaction(CreateRoomTransactionEvent event,
      Emitter<RoomTransactionState> emit) async {
    emit(RoomTransactionListStateLoading());
       await Future.delayed(Duration(seconds: 1));

    final result = await createRoomTransaction.call(
        CreateRoomTransactionParams(roomTransaction: event.roomTransaction));
        
    result.fold(
        (l) => emit(RoomTransactionStateFailure(message: l.message)), (r) {
      emit(RoomTransactionStateCreatedSuccess(roomTransaction: r));
    });
  }


    Future<void> _onRetrieveRoomGuest(
      RetrieveRoomGuestEvent event,
      Emitter<RoomTransactionState> emit) async {


   emit(RoomTransactionListStateLoading());
  //  await Future.delayed(Duration(seconds: 1));
    final result = await retrieveRoomGuest(

        RetrieveRoomGuestParams( id: event.roomGuestId));

    result.fold(
      (failure) =>  emit(RoomTransactionStateFailure(message: failure.message)),
      (r) { emit(RoomTransactionStateRetrievedRoomGuestSuccess(roomGuest: r)); }
    );
  }
  
}

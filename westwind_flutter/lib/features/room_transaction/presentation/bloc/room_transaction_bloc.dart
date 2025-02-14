import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/retrieve_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/retrieve_room_guest.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_Transaction_list_usercase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_create_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_delete_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_list_by_day_usercase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_retrieve_usecase.dart';
import 'package:westwind_flutter/features/room_transaction/domain/usecases/room_transaction_retrieve_without_laundry_usecase.dart';

part 'room_transaction_event.dart';
part 'room_transaction_state.dart';

class RoomTransactionBloc
    extends Bloc<RoomTransactionEvent, RoomTransactionState> {
  final ListRoomTransactionsUseCase listRoomTransactions;
  final ListRoomTransactionsByDayUseCase listRoomTransactionsByDay;
  final DeleteRoomTransactionUseCase deleteRoomTransaction;
  final RetrieveRoomTransactionUseCase retrieveRoomTransaction;
  final CreateRoomTransactionUseCase createRoomTransaction;
  final RetrieveRoomGuestUseCase retrieveRoomGuest;
  final RetrieveGuestUseCase retrieveGuest;


  RoomTransactionBloc({
    required this.listRoomTransactions,
    required this.listRoomTransactionsByDay,
    required this.deleteRoomTransaction,
    required this.retrieveRoomTransaction,
    required this.createRoomTransaction,
    required this.retrieveRoomGuest,
    required this.retrieveGuest,
  }) : super(RoomTransactionListStateInitial()) {
    // add(FetchRoomTransactionsEvent()); // Add this lin
    on<FetchRoomTransactionsEvent>((_onFetchRoomTransactions));
    on<FetchRoomTransactionsByDayEvent>((_onFetchRoomTransactionsByDay));
    on<DeleteRoomTransactionEvent>((_onDeleteRoomTransaction));
    on<RetrieveRoomTransactionEvent>((_onRetrieveRoomTransaction));
    on<CreateRoomTransactionEvent>((_onCreateRoomTransaction));
    on<RetrieveRoomGuestEvent>((_onRetrieveRoomGuest));
    on<RetrieveGuestEvent>((_onRetrieveGuestRoomTransaction));

  }

  Future<void> _onFetchRoomTransactions(
      RoomTransactionEvent event, Emitter<RoomTransactionState> emit) async {
    emit(RoomTransactionListStateLoading());

    final result = await listRoomTransactions.call(NoParams());
    result.fold((l) => emit(RoomTransactionStateFailure(message: l.message)),
        (r) {
      emit(RoomTransactionListStateLoaded(roomTransactions: r));
    });
  }


  Future<void> _onFetchRoomTransactionsByDay (
    FetchRoomTransactionsByDayEvent event,
    Emitter<RoomTransactionState> emit,
  ) async {
    emit(RoomTransactionListStateLoading());
    //  await Future.delayed(Duration(seconds: 1));

    final result = await listRoomTransactionsByDay
        .call(ListRoomTransactionsByDayParams( day: event.day));
    result.fold((l) => emit(RoomTransactionStateFailure(message: l.message)),
        (r) {
      emit(RoomTransactionListByDayStateLoaded(roomTransactions: r));
    });
  }




  void _onDeleteRoomTransaction(
    DeleteRoomTransactionEvent event,
    Emitter<RoomTransactionState> emit,
  ) async {
    emit(RoomTransactionListStateLoading());
    //  await Future.delayed(Duration(seconds: 1));

    final result = await deleteRoomTransaction
        .call(DeleteRoomTransactionParams(id: event.id));
    result.fold((l) => emit(RoomTransactionStateFailure(message: l.message)),
        (r) {
      if (r) {
        emit(RoomTransactionStateDeletedSuccess(id: event.id));
      } else {
        // emit(RoomTransactionStateFailure( Failure( "Failed to delete room transaction" ) ));
      }
    });
  }


  void _onRetrieveRoomTransaction(
    RetrieveRoomTransactionEvent event,
    Emitter<RoomTransactionState> emit,
  ) async {
    emit(RoomTransactionListStateLoading());
    //  await Future.delayed(Duration(seconds: 1));

    final result = await retrieveRoomTransaction
        .call(RetrieveRoomTransactionParams(id: event.id));
    result.fold((l) => emit(RoomTransactionStateFailure(message: l.message)),
        (r) {
      emit(RoomTransactionStateRetrievedSuccess(roomTransaction: r));
    });
  }

  void _onCreateRoomTransaction(CreateRoomTransactionEvent event,
      Emitter<RoomTransactionState> emit,) async {
    emit(RoomTransactionListStateLoading());
    //      await Future.delayed(Duration(seconds: 1));

    final result = await createRoomTransaction.call(
        CreateRoomTransactionParams(roomTransaction: event.roomTransaction));

    result.fold((l) => emit(RoomTransactionStateFailure(message: l.message)),
        (r) {
      emit(RoomTransactionStateCreatedSuccess(roomTransaction: r));
    });
  }

  Future<void> _onRetrieveRoomGuest(
      RetrieveRoomGuestEvent event, Emitter<RoomTransactionState> emit,) async {
    emit(RoomTransactionListStateLoading());
    //  await Future.delayed(Duration(seconds: 1));
    final result =
        await retrieveRoomGuest(RetrieveRoomGuestParams(id: event.roomGuestId));

    result.fold(
        (failure) =>
            emit(RoomTransactionStateFailure(message: failure.message)), (r) {
      emit(RoomTransactionStateRetrievedRoomGuestSuccess(roomGuest: r));
    });
  }

  Future<void> _onRetrieveGuestRoomTransaction(
      RetrieveGuestEvent event, Emitter<RoomTransactionState> emit,) async {
    emit(RoomTransactionListStateLoading());
    // await Future.delayed(Duration(seconds: 1));

    final result = await retrieveGuest(RetrieveGuestParams(id: event.guestId));

    result.fold(
      (failure) => emit(RoomTransactionStateFailure(message: failure.message)),
      (guest) => emit(RoomTransactionStateRetrieveGuestSuccess(guest)),
    );
  }

/*

  Future<void> _onRetrieveGuestByPhoneForReservation(
      RetrieveGuestByPhoneForReservation event,
      Emitter<ReservationManageState> emit) async {
    emit(ReservationManageStateLoading());
  //  await Future.delayed(Duration(seconds: 1));
    final result = await retrieveGuestByPhone(
        RetrieveGuestByPhoneParams(phone: event.phone));

    result.fold(
      (failure) => emit(ReservationManageStateFailure(failure.message)),
      (guest) => emit(ReservationManageStateRetrieveGuestByPhoneSuccess(guest)),
    );
  }
  */
}

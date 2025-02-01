import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/list_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/list_room_guest_but_co.dart';

part 'room_guest_list_event.dart';
part 'room_guest_list_state.dart';

class RoomGuestListBloc extends Bloc<RoomGuestListEvent, RoomGuestListState> {
  final ListRoomGuestUseCase listRoomGuests;
  final ListRoomGuestButCOUseCase listRoomGuestsButCO;

  RoomGuestListBloc(
      {required this.listRoomGuests, required this.listRoomGuestsButCO})
      : super(RoomGuestListStateInitial()) {
    on<RoomGuestListEvent>((event, emit) {
      emit(RoomGuestListStateLoading());
    });
    on<FetchRoomGuestsEvent>((_onFetchRoomGuests));
    on<FetchRoomGuestsButCOEvent>((_onFetchRoomGuestsButCO));
  }

  Future<void> _onFetchRoomGuests(
      FetchRoomGuestsEvent event, Emitter<RoomGuestListState> emit) async {
    emit(RoomGuestListStateLoading());
    // await Future.delayed(Duration(seconds: 1));
    final result = await listRoomGuests(NoParams());

    result.fold(
      (failure) => emit(RoomGuestListStateFailure(failure.message)),
      (roomGuests) => emit(RoomGuestListStateLoaded(roomGuests)),
    );

    return;
  }

  Future<void> _onFetchRoomGuestsButCO(
      FetchRoomGuestsButCOEvent event, Emitter<RoomGuestListState> emit) async {
    emit(RoomGuestListStateLoading());
    // await Future.delayed(Duration(seconds: 1));
    final result = await listRoomGuestsButCO(NoParams());

    result.fold(
      (failure) => emit(RoomGuestListStateFailure(failure.message)),
      (roomGuests) => emit(RoomGuestListStateLoaded(roomGuests)),
    );

    return;
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/list_room_guest.dart';

part 'room_guest_list_event.dart';
part 'room_guest_list_state.dart';

class RoomGuestListBloc extends Bloc<RoomGuestListEvent, RoomGuestListState> {
  final ListRoomGuestUseCase listRoomGuests;

  RoomGuestListBloc(
    {required this.listRoomGuests } 
  ) : super(RoomGuestListStateInitial()) {
    on<RoomGuestListEvent>((event, emit) {
      emit(RoomGuestListStateLoading());
    });
    on<FetchRoomGuestsEvent>((_onFetchRoomGuests));
  }

  Future<void> _onFetchRoomGuests(
      FetchRoomGuestsEvent event, Emitter<RoomGuestListState> emit) async {
    emit(RoomGuestListStateLoading());
    final result = await listRoomGuests(NoParams());

    result.fold(
      (failure) => emit(RoomGuestListStateFailure(failure.message)),
      (roomGuests) => emit(RoomGuestListStateLoaded(roomGuests)),
    );

    return;
  }
}

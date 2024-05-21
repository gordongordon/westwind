import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/check_in_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/delete_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/retrieve_room_guest.dart';

part 'room_guest_manage_event.dart';
part 'room_guest_manage_state.dart';

class RoomGuestManageBloc
    extends Bloc<RoomGuestManageEvent, RoomGuestManageState> {
  final DeleteRoomGuestUseCase deleteRoomGuest;
  final RetrieveRoomGuestUseCase retrieveRoomGuest;
  final CheckInRoomGuestUseCase checkInRoomGuest;

  RoomGuestManageBloc(
    this.deleteRoomGuest,
    this.checkInRoomGuest,
    this.retrieveRoomGuest,
  ) : super(RoomGuestManageStateInitial()) {
    on<RoomGuestManageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DeleteRoomGuest>(_onDeleteRoomGuest);
    on<RetrieveRoomGuest>(_onRetrieveRoomGuest);
    on<CheckInRoomGuest>(_onCheckInRoomGuest);
  }

  Future<void> _onDeleteRoomGuest(
    DeleteRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    final result = await deleteRoomGuest(DeleteRoomGuestParams(id: event.id));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (_) => emit(RoomGuestManageStateDeleteSuccess()),
    );

    return;
  }

  Future<void> _onRetrieveRoomGuest(
    RetrieveRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    final result =
        await retrieveRoomGuest(RetrieveRoomGuestParams(id: event.id));

    result.fold(
      (failure) => emit( RoomGuestManageStateFailure(failure.message)),
      (roomGuest) => emit( RoomGuestManageStateRetrieveSuccess(roomGuest)),
    );

    return;
  }

  Future<void> _onCheckInRoomGuest(
    CheckInRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    final result = await checkInRoomGuest( CheckInRoomGuestParams( reservation: event.reservation ) );

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (_) => emit(RoomGuestManageStateDeleteSuccess()),
    );

    return;
  }

}


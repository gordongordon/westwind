import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/calculate_rate_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/charge_and_extend_stay_day.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/charge_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/check_in_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/delete_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/retrieve_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/extend_stay_day_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/save_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/update_room_guest_note.dart';

part 'room_guest_manage_event.dart';
part 'room_guest_manage_state.dart';

class RoomGuestManageBloc
    extends Bloc<RoomGuestManageEvent, RoomGuestManageState> {
  final DeleteRoomGuestUseCase deleteRoomGuest;
  final RetrieveRoomGuestUseCase retrieveRoomGuest;
  final CheckInRoomGuestUseCase checkInRoomGuest;
  final CalculateRateRoomGuestUseCase calculateRateRoomGuest;
  final ChargeRoomGuestUseCase chargeRoomGuest;
  final ExtendStayDayRoomGuestUseCase extendStayDayRoomGuest;
  final ChargeAndExtendStayDayUseCase chargeAndExtendStayDayRoomGuest;
  final SaveRoomGuestUseCase saveRoomGuest;
  final UpdateRoomGuestNoteUseCase updateRoomGuestNote;

  RoomGuestManageBloc({
    required this.deleteRoomGuest,
    required this.checkInRoomGuest,
    required this.retrieveRoomGuest,
    required this.calculateRateRoomGuest,
    required this.chargeRoomGuest,
    required this.extendStayDayRoomGuest,
    required this.chargeAndExtendStayDayRoomGuest,
    required this.saveRoomGuest,
    required this.updateRoomGuestNote,
  }) : super(RoomGuestManageStateInitial()) {
    on<RoomGuestManageEvent>((event, emit) {
      emit(RoomGuestManageStateLoading());
    });

    on<DeleteRoomGuest>(_onDeleteRoomGuest);
    on<RetrieveRoomGuest>(_onRetrieveRoomGuest);
    on<CheckInRoomGuest>(_onCheckInRoomGuest);
    on<CalculateRateRoomGuest>(_onCalculateRateRoomGuest);
    on<ChargeRoomGuest>(_onChargeRoomGuest);
    on<ExtendStayDayRoomGuest>(_onExtendStayDayRoomGuest);
    on<ChargeAndExtendStayDay>(_onChargeAndExtendStay);
    on<SaveRoomGuest>(_onSaveRoomGuest);
    on<UpdateRoomGuestNote>(_onUpdateRoomGuestNote); 
  }

  Future<void> _onUpdateRoomGuestNote( UpdateRoomGuestNote event , Emitter<RoomGuestManageState> emit) async {

    emit(RoomGuestManageStateLoading());
   // await Future.delayed(Duration(seconds: 1));

    final result =
        await updateRoomGuestNote(UpdateRoomGuestNoteParams(roomGuestId : event.roomGuestId,  note: event.note ));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (_) => emit(RoomGuestManageStateUpdateNoteSuccess()),
    );

    return;


  }

  Future<void> _onSaveRoomGuest(
    SaveRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    emit(RoomGuestManageStateLoading());
   // await Future.delayed(Duration(seconds: 1));

    final result =
        await saveRoomGuest(SaveRoomGuestParams(roomGuest: event.roomGuest));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (roomGuest) => emit(RoomGuestManageStateSaveSuccess(roomGuest)),
    );

    return;
  }

  Future<void> _onChargeAndExtendStay(
    ChargeAndExtendStayDay event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    emit(RoomGuestManageStateLoading());
    await Future.delayed(Duration(seconds: 1));
    final result = await chargeAndExtendStayDayRoomGuest(
        ChargeAndExtendStayDayParams(roomGuestId: event.id));

    result.fold((failure) => emit(RoomGuestManageStateFailure(failure.message)),
        (_) => emit(RoomGuestManageStateChargeAndExtendStayDaySuccess()));
  }

  Future<void> _onExtendStayDayRoomGuest(
    ExtendStayDayRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    final result = await extendStayDayRoomGuest(
        ExtendStayDayRoomGuestParams(id: event.id));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (_) => emit(RoomGuestManageStateExtendStayDaySuccess()),
    );

    return;
  }

  Future<void> _onChargeRoomGuest(
    ChargeRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    final result = await chargeRoomGuest(ChargeRoomGuestParams(id: event.id));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (_) => emit(RoomGuestManageStateChargeSuccess()),
    );

    return;
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
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (roomGuest) => emit(RoomGuestManageStateRetrieveSuccess(roomGuest)),
    );

    return;
  }

  Future<void> _onCheckInRoomGuest(
    CheckInRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    final result = await checkInRoomGuest(
        CheckInRoomGuestParams(reservation: event.reservation));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (_) => emit(RoomGuestManageStateDeleteSuccess()),
    );

    return;
  }

  Future<void> _onCalculateRateRoomGuest(
    CalculateRateRoomGuest event,
    Emitter<RoomGuestManageState> emit,
  ) async {
    emit(RoomGuestManageStateLoading());
    // await Future.delayed(Duration(seconds: 1));

    final result = await calculateRateRoomGuest(
        CalculateRateRoomGuestParams(id: event.id));

    result.fold(
      (failure) => emit(RoomGuestManageStateFailure(failure.message)),
      (roomGuests) => emit(RoomGuestManageStateCalculateRateSuccess(roomGuests)),
    );

    return;
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room/domain/repositories/room_repository.dart';
import 'package:westwind_flutter/features/room/domain/usecases/room_toggle_roomstatus_usecase.dart';

part 'room_toggle_event.dart';
part 'room_toggle_state.dart';

class RoomToggleBloc extends Bloc<RoomToggleEvent, RoomToggleState> {
  final ToggleRoomStatusUseCase toggleRoomStatus;

  RoomToggleBloc({
    required this.toggleRoomStatus, required RoomRepository roomRepository,
  }) : super(RoomToggleStateInitial()) {
    
    on<RoomToggleEvent>((event, emit) {
      emit(RoomToggleStateLoading());
    });

   on<ToggleRoomStatus>((_onToggleRoomStatus));
  }

  Future<void> _onToggleRoomStatus(
    ToggleRoomStatus event,
    Emitter<RoomToggleState> emit,
  ) async {
    emit(RoomToggleStateLoading());

    await Future.delayed(Duration(seconds: 1));

    final result = await toggleRoomStatus(ToggleRoomStatusParams(id: event.id ));

    result.fold(
      (failure) => emit(RoomToggleStateFailure(failure.message)),
      (room) => emit(RoomToggleStateLoaded(room)),
    );

    return;
  }
}

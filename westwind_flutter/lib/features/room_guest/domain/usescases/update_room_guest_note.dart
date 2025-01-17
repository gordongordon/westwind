import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class UpdateRoomGuestNoteUseCase implements UseCase<RoomGuest?, UpdateRoomGuestNoteParams> {
  final RoomGuestRepository roomGuestRepository;

  UpdateRoomGuestNoteUseCase(this.roomGuestRepository);

  @override
  Future<Either<Failure, RoomGuest?>> call(UpdateRoomGuestNoteParams params) async {
    return await roomGuestRepository.updateNote( roomGuestId : params.roomGuestId , note: params.note  );
  }
}

class UpdateRoomGuestNoteParams {
  final int roomGuestId;
  final String note;

  UpdateRoomGuestNoteParams({required this.roomGuestId, required this.note });
}

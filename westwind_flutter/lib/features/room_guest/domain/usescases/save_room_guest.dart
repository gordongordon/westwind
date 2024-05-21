import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class SaveRoomGuestUseCase implements UseCase<RoomGuest, SaveRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;

  SaveRoomGuestUseCase(this.roomGuestRepository);

  @override
  Future<Either<Failure, RoomGuest>> call(SaveRoomGuestParams params) async {
    return await roomGuestRepository.save(roomGuest: params.roomGuest);
  }
}

class SaveRoomGuestParams {
  final RoomGuest roomGuest;

  SaveRoomGuestParams({required this.roomGuest});
}

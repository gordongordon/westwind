import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class DeleteRoomGuestUseCase
    implements UseCase<bool, DeleteRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;

  DeleteRoomGuestUseCase(this.roomGuestRepository);

  @override
  Future<Either<Failure, bool>> call(
      DeleteRoomGuestParams params) async {
    return await roomGuestRepository.delete(params.id);
  }
}

class DeleteRoomGuestParams {
  final int id;

  DeleteRoomGuestParams({required this.id});
}
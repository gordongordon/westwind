import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class RetrieveRoomGuestUseCase
    implements UseCase<RoomGuest, RetrieveRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;

  RetrieveRoomGuestUseCase(this.roomGuestRepository);

  @override
  Future<Either<Failure, RoomGuest>> call(
      RetrieveRoomGuestParams params) async {
    return await roomGuestRepository.retrieve(params.id);
  }
}

class RetrieveRoomGuestParams {
  final int id;

  RetrieveRoomGuestParams({required this.id});
}

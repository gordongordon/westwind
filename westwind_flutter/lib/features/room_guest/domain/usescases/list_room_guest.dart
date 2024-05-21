import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class ListRoomGuestUseCase
    implements UseCase<List<RoomGuest>, NoParams> {
  final RoomGuestRepository roomGuestRepository;

  ListRoomGuestUseCase(this.roomGuestRepository);

  @override
  Future<Either<Failure, List<RoomGuest>>> call(NoParams _) async {
    return await roomGuestRepository.list();
  }
}


import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:westwind_flutter/features/room/domain/repositories/room_repository.dart';

class ToggleRoomStatusUseCase implements UseCase<Room, ToggleRoomStatusParams> {
   final RoomRepository roomRepository;

   const ToggleRoomStatusUseCase( this.roomRepository );

  @override
  Future<Either<Failure, Room>> call(ToggleRoomStatusParams params) async {
    return await roomRepository.toggleRoomStatus(params.id);
  }

}

class ToggleRoomStatusParams {
   final int id;

   const ToggleRoomStatusParams( {required this.id} );
}
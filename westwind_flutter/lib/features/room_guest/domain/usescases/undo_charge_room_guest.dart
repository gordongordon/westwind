import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class UndoChargeRoomGuestUseCase   implements UseCase<bool, UndoChargeRoomGuestParams > {

  final RoomTransactionRepository roomTransactionRepository;

  UndoChargeRoomGuestUseCase( this.roomTransactionRepository );


  @override
  Future<Either<Failure, bool>> call(UndoChargeRoomGuestParams params) async {


    return await roomTransactionRepository.delete(params.roomTransactionId);
  }
    // Implementation to undo the charge
}

class UndoChargeRoomGuestParams {
  final int roomTransactionId;

  UndoChargeRoomGuestParams({required this.roomTransactionId});
}
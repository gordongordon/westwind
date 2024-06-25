import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class ChargeRoomGuestUseCase
    implements UseCase<RoomTransaction, ChargeRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;
  final RoomTransactionRepository roomTransactionRepository;

  ChargeRoomGuestUseCase(this.roomGuestRepository, this.roomTransactionRepository);

  @override
  Future<Either<Failure, RoomTransaction>> call(
      ChargeRoomGuestParams params) async {
    // Get RoomGuest
    final rg = foldResult(await roomGuestRepository.retrieve(params.id));

    // Crate RoomTransaction

    final roomTransaction = RoomTransaction(
        guestId: rg.guestId,
        roomId: rg.roomId,
        roomGuestId: params.id,
        stayDay: rg.stayDate,
        transactionDay: DateTime.now(),
        transactionType: TransactionType.charge,
        amount: rg.rate,
        tax1: 5,
        tax2: 0,
        tax3: 0,
        total: rg.rate + 5,
        description: rg.rateReason.toString(),
        itemType: ItemType.room)
        ;

    // Insert RoomTransaction
    return roomTransactionRepository.save(roomTransaction);
  }


  Future<Either<Failure, bool>> undo(ChargeRoomGuestParams params) async {
    return await roomTransactionRepository.delete(params.id);
  }

  RoomGuest foldResult(Either<Failure, RoomGuest> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }
}

class ChargeRoomGuestParams {

  //! id can be either roomGuest id or roomTransaction id, since implemented undo
  final int id;  
 // final int roomTransactioinId; 

  ChargeRoomGuestParams({required this.id});
}

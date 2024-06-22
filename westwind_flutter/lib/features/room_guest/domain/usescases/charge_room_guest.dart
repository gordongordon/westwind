import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class ChargeRoomGuestUseCase
    implements UseCase<List<RoomGuest>, ChargeRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;
  final RoomTransactionRepository roomTransactionRepository;

  ChargeRoomGuestUseCase(this.roomGuestRepository, this.roomTransactionRepository);

  @override
  Future<Either<Failure, List<RoomGuest>>> call(
      ChargeRoomGuestParams params) async {
    // Get RoomGuest
    final rg = foldResult(await roomGuestRepository.retrieve(params.id));

    // Crate RoomTransaction

    final roomTransaction = RoomTransaction(
        guestId: rg.guestId,
        roomId: rg.roomId,
        transactionDay: DateTime.now(),
        transactionType: TransactionType.charge,
        amount: rg.rate,
        tax1: 5,
        tax2: 0,
        tax3: 0,
        total: rg.rate + 5,
        description: rg.rateReason.toString(),
        itemType: ItemType.room);

    // Insert RoomTransaction
    roomTransactionRepository.create(roomTransaction);

    // Move StayDate by one day.

    rg.stayDate = rg.stayDate.add(Duration(days: 1));

    // final List<RoomGuest> listOfRoomGuest = []
    
/**
   * This method handles the logic of charging a guest. It retrieves the 
   * specified room guest, creates a new room transaction, and then updates the
   * stay date of the room guest. Finally, it returns the updated list of 
   * room guests.
   */

   // roomGuestRepository.update(roomGuests: [rg]);

    return roomGuestRepository.update(roomGuests: [rg]);
  }

  RoomGuest foldResult(Either<Failure, RoomGuest> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }
}

class ChargeRoomGuestParams {
  final int id;

  ChargeRoomGuestParams({required this.id});
}

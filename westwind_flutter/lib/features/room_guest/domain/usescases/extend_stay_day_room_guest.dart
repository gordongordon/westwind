import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class ExtendStayDayRoomGuestUseCase
    implements UseCase<List<RoomGuest>, ExtendStayDayRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;

  ExtendStayDayRoomGuestUseCase(this.roomGuestRepository );

  @override
  Future<Either<Failure, List<RoomGuest>>> call(
      ExtendStayDayRoomGuestParams params) async {
    // Get RoomGuest
    final rg = foldResult(await roomGuestRepository.retrieve( params.id ));

    rg.stayDay = rg.stayDay.add(Duration(days: 1));

    if ( rg.roomTransactions != null ) {
       debugPrint( rg.roomTransactions!.first.toString() );
    } else 
    {
      debugPrint( "rg.roomTransactions == null ");
    }

    return roomGuestRepository.update(roomGuests: [rg]);
  }

  RoomGuest foldResult(Either<Failure, RoomGuest> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }
}

class ExtendStayDayRoomGuestParams {
  final int id;

  ExtendStayDayRoomGuestParams ({required this.id});
}
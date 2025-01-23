import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/go_home_room_guest.dart';

// This use case handles the calculation of room rates for a given room guest.
class CalculateRateRoomGuestUseCase
    implements UseCase<List<RoomGuest>, CalculateRateRoomGuestParams> {
  // Injected dependencies: Room Guest Repository, Rate Table Repository, and Go Home Room Guest Use Case.
  final RoomGuestRepository roomGuestRepository;
  final RateTableRepository rateTableRepository;
  final GoHomeRoomGuestUseCase goHomeRoomGuestUseCase;
//  final DoubleRoomGuestUseCase doubleRoomGuestUseCase;

  CalculateRateRoomGuestUseCase(
    this.roomGuestRepository,
    this.rateTableRepository,
    this.goHomeRoomGuestUseCase,
 //   this.doubleRoomGuestUseCase,
  );

  @override
  Future<Either<Failure, List<RoomGuest>>> call(
      CalculateRateRoomGuestParams params) async {
    // Retrieve the room guest with the given ID.
    final result = await roomGuestRepository.retrieve(params.id);
    final id = params.id;
    // Handle the retrieval result and get the room guest entity.
    final roomGuest = result.foldResult();
    final roommates =
        (await roomGuestRepository.retrieveRoommatesSameStayDayById(id))
            .foldResult();

    // Check if there are any room guests with a rate reason of GoHome.
    if (roommates.isEmpty) {
      // Return an error if no room guests found for the given ID.
      return Left(Failure("no roomGuest for id of $id!"));
    }

    // Get the type of rate for the room guest.
    final type = roomGuest.rateType;

    // Use the Go Home Room Guest Use Case to go home from the current room.
    goHomeRoomGuestUseCase(GoHomeRoomGuestParams(id: roomGuest.id!));

    // Remove any room guests with a rate reason of GoHome from the list.
    roommates
        .removeWhere((roomGuest) => roomGuest.rateReason == RateReason.gohome);

    // Get the number of room guests.
    final numOfRoomGuests = roommates.length;

    debugPrint(" Num of room guests $numOfRoomGuests & type of $type");

    // Determine the rate reason based on the number of room guests.
    late RateReason reason;

    if (roomGuest.rateReason == RateReason.double) {
      reason = RateReason.double;
    } else {
      switch (numOfRoomGuests) {
        case 1:
          reason = RateReason.single;
          break;
        case 2:
          reason = RateReason.share;
          break;
        case 3:
          reason = RateReason.triple;
          break;
      }
    }

    //  = numOfRoomGuests == 1
    //     ? RateReason.single
    //     : (numOfRoomGuests == 2 ? RateReason.share : (numOfRoomGuests ==3 ? RateReason.triple);

    // Calculate the rate for the given type and rate reason.
    final rate = (await rateTableRepository.getRate(type, reason)).foldResult();

    // Update each roommate's rate and rate reason.
    _updateRoomMatesRateAndReason(roommates, rate, reason);

    debugPrint("update RoomMates $roommates");

    // Update the room guests in the repository.
    return await roomGuestRepository.update(roomGuests: roommates);
  }

// New method to update the rate and rate reason for each roommate
  void _updateRoomMatesRateAndReason(
      List<RoomGuest> roommates, double rate, RateReason reason) {
    for (var roommate in roommates) {
      if (roommate.rateReason == RateReason.gohome) {
        roommate.rate = 0;
        roommate.rateReason = RateReason.gohome;
      } else {
        roommate.rate = rate;
        roommate.rateReason = reason;
      }
    }
  }

/*
  Future<double> handleRateTypeCalculation(
      RateReason reason, RateType type) async {
    late Either<Failure, double> resultRate;

    switch (reason) {
      case RateReason.single:
        {
          // single rate
          resultRate = await rateTableRepository.getShareRate(type);
        }
        break;
      case RateReason.share:
        {
          // single rate
          resultRate = await rateTableRepository.getShareRate(type);
        }
        break;
      case RateReason.triple:
        {
          // single rate
          resultRate = await rateTableRepository.getSingleRate(type);
        }
        break;
      case RateReason.double:
        {
          // single rate
          resultRate = await rateTableRepository.getSingleRate(type);
        }
        break;
      case RateReason.stuff:
        {
          // single rate
          resultRate = await rateTableRepository.getSingleRate(type);
        }
        break;
      case RateReason.gohome:
        {
          resultRate = await rateTableRepository.getRate(RateReason.gohome);
        }
        break;
      case RateReason.other:
        {
          // single rate
          resultRate = await rateTableRepository.getSingleRate(type);
        }
        break;
    }

    return resultRate.foldResult();
  }
  */
}

class CalculateRateRoomGuestParams {
  final int id;

  CalculateRateRoomGuestParams({required this.id});
}

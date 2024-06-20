import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class CalculateRateRoomGuestUseCase
    implements UseCase<List<RoomGuest>, CalculateRateRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;
  final RateTableRepository rateTableRepository;

  CalculateRateRoomGuestUseCase(
      this.roomGuestRepository, this.rateTableRepository);

  @override
  Future<Either<Failure, List<RoomGuest>>> call(
      CalculateRateRoomGuestParams params) async {

    // roomGuest;
    // Get roommates
    // Get rateType ironhandle or other
    // Get roomates.rateReason == GoHome
    // Remove any GoHome Roommates

    // Get total roommates
    // If totalRoommates  == 1,  reason = single
    // if totalRoommates  == 2,  reason = share
    // if totalRoommates  == 3, reason = triple

    final result = await roomGuestRepository.retrieve(params.id);

    final roomGuest = foldResult(result);
    final roommates = await handleRetrieveByRoomId(roomGuest.roomId);

    if (roommates.isEmpty) {
      return Left(Failure("no roommates for the $roomGuest !"));
    }

    final type = roommates.first.rateType;
    //  final reason = roommates.first.rateReason;
    //  late RateReason reason;
    double rate = 0;

    final numOfRoomGuests = roommates.length;

    debugPrint(" Num of room guests $numOfRoomGuests & type of $type");

    /// Removes any room guests with a rate reason of GoHome from the list.
    roommates
        .removeWhere((roomGuest) => roomGuest.rateReason == RateReason.gohome);

    final RateReason reason = numOfRoomGuests == 1
        ? RateReason.single
        : (numOfRoomGuests == 2 ? RateReason.share : RateReason.triple);

    /* 
    if ( roommates.isEmpty ) {
      return Left(Failure("no roommates for the $roomGuest !"));
    }
    */


    rate = await handleRateTypeCalculation(reason, type);
/*
    if ( rate == 0  ) {
         throw 
    }
    */

    // Update each roommate's rate and rate reason
    _updateRoomMatesRateAndReason(roommates, rate, reason);

    debugPrint("update RoomMates $roommates");
    return await roomGuestRepository.update(roomGuests: roommates);
  }

// New method to update the rate and rate reason for each roommate
  void _updateRoomMatesRateAndReason(
      List<RoomGuest> roommates, double rate, RateReason reason) {
    for (var roommate in roommates) {
      roommate.rate = rate;
      roommate.rateReason = reason;
    }
  }

  Future<double> handleRateTypeCalculation(RateReason reason, RateType type) async {
    double rate = 0;

    switch (reason) {
      case RateReason.single:
        {

          // single rate
          final resultRate = await rateTableRepository.getSingleRate(type);

          late Failure resultFailure;

          resultRate.fold(
              (failure) =>
                  resultFailure = failure, // Throw the error if it exists
              (r) => rate = r); // Return the result if there is no error


        }
        break;
      case RateReason.share:
        {
          // single rate
          final resultRate = await rateTableRepository.getShareRate(type);

          late Failure resultFailure;

          resultRate.fold(
              (failure) =>
                  resultFailure = failure, // Throw the error if it exists
              (r) => rate = r); // Return the result if there is no error


        }
        break;
      case RateReason.triple:{

          // single rate
          final resultRate = await rateTableRepository.getSingleRate(type);

          late Failure resultFailure;

          resultRate.fold(
              (failure) =>
                  resultFailure = failure, // Throw the error if it exists
              (r) => rate = r); // Return the result if there is no error


        }
        break;
      case RateReason.double:
        {

          // single rate
          final resultRate = await rateTableRepository.getSingleRate(type);

          late Failure resultFailure;

          resultRate.fold(
              (failure) =>
                  resultFailure = failure, // Throw the error if it exists
              (r) => rate = r); // Return the result if there is no error


        }
        break;
      case RateReason.stuff:
        {
          //   rate = await rateTableRepository.getSingleRate(roomId);

          // single rate
          final resultRate = await rateTableRepository.getSingleRate(type);

          late Failure resultFailure;

          resultRate.fold(
              (failure) =>
                  resultFailure = failure, // Throw the error if it exists
              (r) => rate = r); // Return the result if there is no error

        }
        break;
      case RateReason.gohome: {
     //   rate = await rateTableRepository.getSingleRate(roomId);

              // single rate
      final resultRate = await rateTableRepository.getSingleRate(type);

      late Failure resultFailure;

      resultRate.fold(
          (failure) => resultFailure = failure, // Throw the error if it exists
          (r) => rate = r); // Return the result if there is no error


      }
        break;
      case RateReason.other: {
     //   rate = await rateTableRepository.getSingleRate(roomId);

              // single rate
      final resultRate = await rateTableRepository.getSingleRate(type);

      late Failure resultFailure;

      resultRate.fold(
          (failure) => resultFailure = failure, // Throw the error if it exists
          (r) => rate = r); // Return the result if there is no error


      }
        break;
    }

    return rate;
  }

// New methods to handle errors and return the results of asynchronous operations
  bool handleHasRoommate(Either<Failure, bool> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }

  RoomGuest foldResult(Either<Failure, RoomGuest> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }

  double handleRate(Either<Failure, double> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }

// New method to retrieve a list of RoomGuest objects by room ID
  Future<List<RoomGuest>> handleRetrieveByRoomId(int id) async {
    final result = await roomGuestRepository.retrieveByRoomId(id);

    return result.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }
}

class CalculateRateRoomGuestParams {
  final int id;

  CalculateRateRoomGuestParams({required this.id});
}

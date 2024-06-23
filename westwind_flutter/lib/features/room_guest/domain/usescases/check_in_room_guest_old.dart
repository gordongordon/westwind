import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class CheckInRoomGuestUseCase
    implements UseCase<RoomGuest, CheckInRoomGuestParams> {
  final RoomGuestRepository roomGuestRepository;
  final RateTableRepository rateTableRepository;

  CheckInRoomGuestUseCase(this.roomGuestRepository, this.rateTableRepository);

@override
Future<Either<Failure, RoomGuest>> call(CheckInRoomGuestParams params) async {
  
  final reservation = params.reservation;
  
  // Calculate rate
  final rate = await computeRate(reservation);
  
  // Retrieve roommates
  final roommates = await handleRetrieveByRoomId(reservation.roomId);

  // Determine the RateReason based on whether there are any roommates
  final reason = roommates.isEmpty ? RateReason.single : RateReason.share;
  
  // Update each roommate's rate and rate reason
  _updateRoomMatesRateAndReason(roommates, rate, reason);

  // Create RoomGuest object with calculated values
  final roomGuest = createRoomGuestObject(reservation, rate, reason);

  
  return await roomGuestRepository.checkIn(
    checkInRoomGuest: roomGuest,
   // roommates: roommates,
    reservation: reservation,
    );
}

// New method to update the rate and rate reason for each roommate
void _updateRoomMatesRateAndReason(List<RoomGuest> roommates, double rate, RateReason reason) {
  for (var roommate in roommates) {
    roommate.rate = rate;
    roommate.rateReason = reason;
  }
}

// New method to create a RoomGuest object with the given parameters
RoomGuest createRoomGuestObject(Reservation reservation, double rate, RateReason reason) {
  return RoomGuest(
      roomId: reservation.roomId,
      stayDate: DateTime.now(),
      guestId: reservation.guestId,
      rateType: reservation.rateType,
      rateReason: reason,
      rate: rate,
      reservationId: reservation.id!,
      roomStatus: RoomStatus.change,
      checkInDate: DateTime.now(),
      checkOutDate: reservation.checkOutDate);
}

// New methods to handle errors and return the results of asynchronous operations
  bool handleHasRoommate(Either<Failure, bool> input) {
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

// New method to compute the rate based on whether there are roommates
  Future<double> computeRate(Reservation reservation) async {
    final result = await roomGuestRepository.hasRoomate(reservation.roomId);

    if (handleHasRoommate(result) == false) {
      // single rate
      final resultRate =
          await rateTableRepository.getSingleRate(reservation.rateType);

      return handleRate(resultRate);
    } else {
      // double rate
      final resultRate =
          await rateTableRepository.getShareRate(reservation.rateType);
      return handleRate(resultRate);
    }
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

class CheckInRoomGuestParams {
  final Reservation reservation;

  CheckInRoomGuestParams({required this.reservation});
}

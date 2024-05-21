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

    final rate = await computeRate(reservation);

    final roommates = await handleRetrieveByRoomId(reservation.roomId);

    final RateReason reason;

    if (roommates.isEmpty) {
      reason = RateReason.single;
    } else {
      reason = RateReason.share;
    }

    roommates.map((e) {
      e.rate = rate;
      e.rateReason = RateReason.share;
      return e;
    }).toList();

    final roomGuest = RoomGuest(
      roomId: reservation.roomId,
      stateDate: DateTime.now(),
      guestId: reservation.guestId,
      rateType: reservation.rateType, //! todo
      rateReason: reason, //! todo
      rate: rate,
      reservationId: reservation.id!,
      roomStatus: RoomStatus.change,
      checkOutDate: reservation.checkOutDate,
    );

    return await roomGuestRepository.checkIn(
      checkInRoomGuest: roomGuest,
      roommates: roommates,
      reservation: reservation,
    );
  }

  bool handleHasRoommate(Either<Failure, bool> input) {
    return input.fold(
      (failure) => throw failure,
      (r) => r,
    );
  }

  double handleRate(Either<Failure, double> input) {
    return input.fold(
      (failure) => throw failure,
      (r) => r,
    );
  }

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

  Future<List<RoomGuest>> handleRetrieveByRoomId(int id) async {
    final result = await roomGuestRepository.retrieveByRoomId(id);

    return result.fold(
      (failure) => throw failure,
      (r) => r,
    );
  }
}

class CheckInRoomGuestParams {
  final Reservation reservation;

  CheckInRoomGuestParams({required this.reservation});
}

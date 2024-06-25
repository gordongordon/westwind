import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/rate_table/data/repositories/rate_table_repository_imp.dart';
import 'package:westwind_flutter/features/rate_table/domain/repositories/rate_table_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class GoHomeRoomGuestUseCase
    implements UseCase<List<RoomGuest>, GoHomeRoomGuestParams> {
  // This class is a use case for retrieving room guests with their go-home rates.
  final RoomGuestRepository roomGuestRepository; // Injected repository for room guests.
  final RateTableRepository rateTableRepository; // Injected repository for rate tables.

  GoHomeRoomGuestUseCase(this.roomGuestRepository, this.rateTableRepository);

  @override
  Future<Either<Failure, List<RoomGuest>>> call(
      GoHomeRoomGuestParams params) async {
    // Call the use case with go-home room guest parameters.
    final result = await roomGuestRepository.retrieve(params.id);
    // Retrieve a room guest based on the provided ID.
    final roomGuest = result.foldResult();

    final resultRate = await rateTableRepository.getRate(
        roomGuest.rateType, RateReason.gohome); // Get the go-home rate for the retrieved room guest.
    final rate = resultRate.foldResult();
    
    return await roomGuestRepository.updateRateSameStayDayByReasonAndId(
      params.id, RateReason.gohome, rate); // Update the room guest's go-home rate.
  }
}

class GoHomeRoomGuestParams {
  // This class represents parameters for a use case that retrieves room guests with their go-home rates.
  final int id;

  GoHomeRoomGuestParams({required this.id});
}

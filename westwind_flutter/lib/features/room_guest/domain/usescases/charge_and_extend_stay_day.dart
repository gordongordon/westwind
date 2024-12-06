import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';
import 'package:westwind_flutter/features/room_guest/domain/services/room_guest_policy_service.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/charge_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/undo_charge_room_guest.dart';
import 'package:westwind_flutter/features/room_guest/domain/usescases/extend_stay_day_room_guest.dart';

class ChargeAndExtendStayDayUseCase
    implements UseCase<bool, ChargeAndExtendStayDayParams> {
  final ChargeRoomGuestUseCase chargeRoomGuest;
  final ExtendStayDayRoomGuestUseCase extendStayDayRoomGuest;
  final UndoChargeRoomGuestUseCase undoChargeRoomGuest;
  final RoomGuestRepository roomGuestRepository;
  final RoomGuestPolicyService policyService;

  ChargeAndExtendStayDayUseCase(
    this.chargeRoomGuest,
    this.extendStayDayRoomGuest,
    this.undoChargeRoomGuest,
    this.roomGuestRepository,
    this.policyService,
  );

  @override
  Future<Either<Failure, bool>> call(
      ChargeAndExtendStayDayParams params) async {
    final result = await policyService.canChargeGuest(params.roomGuestId);

    if (result.isLeft()) {
      // final id = params.roomGuestId;
      return result;
    }

    // First, attempt to charge the room guest
    final chargeResult =
        await chargeRoomGuest(ChargeRoomGuestParams(id: params.roomGuestId));

    return await chargeResult.fold((failure) async => Left(failure),
        (roomTransaction) async {
      // If charge is successful, attempt to update the stay day
      final updateResult = await extendStayDayRoomGuest(
          ExtendStayDayRoomGuestParams(id: params.roomGuestId));

      return await updateResult.fold((failure) async {
        // If update fails, attempt to undo the charge
        final undoResult = await undoChargeRoomGuest(UndoChargeRoomGuestParams(
          roomTransactionId: roomTransaction.id!,
        ));

        return undoResult.fold(
            (undoFailure) => Left(Failure(
                'Failed to update stay day and undo charge: ${undoFailure.message}')),
            (_) => Left(Failure(
                'Failed to update stay day. Charge has been reversed.')));
      }, (_) => Right(true));
    });
  }
}

class ChargeAndExtendStayDayParams {
  final int roomGuestId;

  ChargeAndExtendStayDayParams({required this.roomGuestId});
}

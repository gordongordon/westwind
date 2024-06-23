// In services/room_guest_policy_service.dart
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/features/room_guest/domain/policies/room_guest_policy.dart';
import 'package:westwind_flutter/features/room_guest/domain/repositories/room_guest_repository.dart';

class RoomGuestPolicyService {

  final RoomGuestPolicy policy;
  final RoomGuestRepository roomGuestRepository;

  RoomGuestPolicyService( this.policy, this.roomGuestRepository);

//  @override
  Future<Either<Failure,bool>> canChargeGuest(int guestId) async {
    
    final resultOfRoomGuest = await roomGuestRepository.retrieve(guestId);

    final roomGuest = foldResult( resultOfRoomGuest);

    final result = policy.canChargeGuest(roomGuest);

    if ( !result )  {

      final stayDay = roomGuest.stayDate.getDateOnly().day;
      final today = DateTime.now().toLocal().getDateOnly().day;

      return Left(  Failure( "You can only charge when Stay Day $stayDay less then Today $today " ) );
    }
     
    return Right( result );
  }

  // Implement other methods similarly

  RoomGuest foldResult(Either<Failure, RoomGuest> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }
}

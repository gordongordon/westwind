

import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class RetrieveGuestByPhoneForReservationUseCase implements UseCase<Guest, RetrieveGuestByPhoneForReservationParams> {
 //  final ReservationRepository reservationRepository;
   final GuestRepository guestRepository;

   const RetrieveGuestByPhoneForReservationUseCase( this.guestRepository );

  @override
  Future<Either<Failure, Guest>> call(RetrieveGuestByPhoneForReservationParams params) async {
    return await guestRepository.retrieveByPhone(params.phone);
  }

}

class RetrieveGuestByPhoneForReservationParams {
   final String phone; 

   const RetrieveGuestByPhoneForReservationParams( {required this.phone} );
}
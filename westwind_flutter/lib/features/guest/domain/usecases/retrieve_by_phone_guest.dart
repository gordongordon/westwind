import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class RetrieveGuestByPhoneUseCase implements UseCase<Guest, RetrieveGuestByPhoneParams> {
 //  final ReservationRepository reservationRepository;
   final GuestRepository guestRepository;

   const RetrieveGuestByPhoneUseCase( this.guestRepository );

  @override
  Future<Either<Failure, Guest>> call(RetrieveGuestByPhoneParams params) async {
    return await guestRepository.retrieveByPhone(params.phone);
  }

}

class RetrieveGuestByPhoneParams {
   final String phone; 

   const RetrieveGuestByPhoneParams( {required this.phone} );
}
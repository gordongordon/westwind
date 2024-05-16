

import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class RetrieveGuestForReservationUseCase implements UseCase<Guest, RetrieveGuestForReservationParams> {
 //  final ReservationRepository reservationRepository;
   final GuestRepository guestRepository;

   const RetrieveGuestForReservationUseCase( this.guestRepository );

  @override
  Future<Either<Failure, Guest>> call(RetrieveGuestForReservationParams params) async {
    return await guestRepository.retrieve(params.id);
  }

}

class RetrieveGuestForReservationParams {
   final int id;

   const RetrieveGuestForReservationParams( {required this.id} );
}
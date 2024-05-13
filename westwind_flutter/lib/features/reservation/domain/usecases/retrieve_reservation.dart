

import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class RetrieveReservationUseCase implements UseCase<Reservation, RetrieveReservationParams> {
   final ReservationRepository reservationRepository;

   const RetrieveReservationUseCase( this.reservationRepository );

  @override
  Future<Either<Failure, Reservation>> call(RetrieveReservationParams params) async {
    return await reservationRepository.retrieve(params.id);
  }

}

class RetrieveReservationParams {
   final int id;

   const RetrieveReservationParams( {required this.id} );
}
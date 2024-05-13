
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class SaveReservationUseCase implements UseCase<Reservation, SaveReservationParams> {
  final ReservationRepository reservationRepository;

  const SaveReservationUseCase( this.reservationRepository );

  @override
  Future<Either<Failure, Reservation>> call( SaveReservationParams params) async {
      return await reservationRepository.save( params.reservation );
  }
}

class SaveReservationParams {
  final Reservation reservation;

  const SaveReservationParams( {required this.reservation } );
}
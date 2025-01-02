import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class ExtendReservationUseCase implements UseCase<bool, ExtendReservationParams> {
  final ReservationRepository reservationRepository;

  const ExtendReservationUseCase( this.reservationRepository );

  @override
  Future<Either<Failure, bool>> call( ExtendReservationParams params) async {
      return await reservationRepository.checkIn( params.id );
  }
}

class ExtendReservationParams {
  final int id;

  const ExtendReservationParams( {required this.id } );
}
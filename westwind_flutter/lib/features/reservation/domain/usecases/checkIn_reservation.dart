
import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class CheckInReservationUseCase implements UseCase<bool, CheckInReservationParams> {
  final ReservationRepository reservationRepository;

  const CheckInReservationUseCase( this.reservationRepository );

  @override
  Future<Either<Failure, bool>> call( CheckInReservationParams params) async {
      return await reservationRepository.checkIn( params.id );
  }
}

class CheckInReservationParams {
  final int id;

  const CheckInReservationParams( {required this.id } );
}
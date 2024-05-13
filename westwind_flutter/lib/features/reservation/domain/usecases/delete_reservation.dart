


import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class DeleteReservationUseCase implements UseCase<bool, DeleteReservationParams> {
  final ReservationRepository reservationRepository;

  const DeleteReservationUseCase( this.reservationRepository );

  @override
  Future<Either<Failure, bool>> call(params) async {
      return await reservationRepository.delete(params.id);
  }
}

class DeleteReservationParams {
  final int id;


  const DeleteReservationParams( {required this.id});
}
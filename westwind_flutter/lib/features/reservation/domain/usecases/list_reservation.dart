
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class ListReservationUseCase implements UseCase<List<Reservation>, NoParams > {
   final ReservationRepository reservationRepository;

   ListReservationUseCase( this.reservationRepository );

  @override
  Future<Either<Failure, List<Reservation>>> call(NoParams params) async {
       return await reservationRepository.list();
  }

}
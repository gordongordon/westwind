import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract interface class ReservationRepository {
  Future<Either<Failure, List<Reservation>>> list();
  Future<Either<Failure, List<Reservation>>> listButCanceled();
  Future<Either<Failure, List<Reservation>>> listButCanceledAndCheckIn();
  Future<Either<Failure, Reservation>> retrieve(int id);
  Future<Either<Failure, bool>> delete(int id);
  Future<Either<Failure, Reservation>> save(Reservation reservation);
  Future<Either<Failure, bool>> checkIn(int id);
Future<Either<Failure,List<Reservation>>> findReservatioinsForWindow(
   DateTime startDate, DateTime endDate);
}

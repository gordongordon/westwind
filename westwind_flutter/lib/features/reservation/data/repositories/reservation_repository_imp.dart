import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/reservation/data/datasources/reservation_datasource.dart';
import 'package:westwind_flutter/features/reservation/domain/repositories/reservation_repository.dart';

class ReservationRepositoryImp implements ReservationRepository {
  final ReservationDatasource datasource;

  const ReservationRepositoryImp(this.datasource);

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      return Right(await datasource.delete(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> list() async {
    try {
      // When fetching from server
      final response = await datasource.list();

      final result = response.map(_fromServer).toList();

      return Right(result);

      //  return Right(await datasource.list());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> listButCanceled() async {
    try {
      // When fetching from server
      final response = await datasource.listButCanceled();

      final result = response.map(_fromServer).toList();

      return Right(result);
      //   return Right(await datasource.listButCanceled());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> listButCanceledAndCheckIn() async {
    try {
      // When fetching from server
      final response = await datasource.listButCanceledAndCheckIn();

      final result = response.map(_fromServer).toList();

      return Right(result);
      //   return Right(await datasource.listButCanceled());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Reservation>> retrieve(int id) async {
    try {
      // When fetching from server
      final data = await datasource.retrieve(id);

      final result = _fromServer(data);

      return Right(result);

      //  return Right(await datasource.retrieve(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Reservation>> save(Reservation reservation) async {
    try {
     // final data = reservation;

      final result = _toServer(reservation);

      return Right(await datasource.save(result));
      // return Right(await datasource.save(reservation));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIn(int id) async {
    try {
      return Right(await datasource.checkIn(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Reservation _toServer(Reservation data) {
    return Reservation(
      id: data.id,
      checkInDate: TimeManager.instance.toServer(data.checkInDate),
      checkOutDate: TimeManager.instance.toServer(data.checkOutDate),
      stayDay: TimeManager.instance.toServer(data.stayDay),
      dateCreate: TimeManager.instance.toServer(data.dateCreate),
      dateUpdate: data.dateUpdate != null
          ? TimeManager.instance.toServer(data.dateCreate)
          : null,
      guest: data.guest,
      guestId: data.guestId,
      rateType: data.rateType,
      rateReason: data.rateReason,
      rate: data.rate,
      isCheckedIn: data.isCheckedIn,
      isCanceled: data.isCanceled,
      isNightShift: data.isNightShift,
      roomId: data.roomId,
      room: data.room,
      note: data.note,
    );
  }

  Reservation _fromServer(Reservation data) {
    return Reservation(
      id: data.id,
      checkInDate: TimeManager.instance.fromServer(data.checkInDate),
      checkOutDate: TimeManager.instance.fromServer(data.checkOutDate),
      stayDay: TimeManager.instance.fromServer(data.stayDay),
      dateCreate: TimeManager.instance.fromServer(data.dateCreate),
      dateUpdate: data.dateUpdate != null
          ? TimeManager.instance.fromServer(data.dateCreate)
          : null,
      guest: data.guest,
      guestId: data.guestId,
      rateType: data.rateType,
      rateReason: data.rateReason,
      rate: data.rate,
      isCheckedIn: data.isCheckedIn,
      isCanceled: data.isCanceled,
      isNightShift: data.isNightShift,
      roomId: data.roomId,
      room: data.room,
      note: data.note,
    );
  }
}

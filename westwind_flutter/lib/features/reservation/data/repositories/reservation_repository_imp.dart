
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
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
      return Right(await datasource.list());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

    @override
  Future<Either<Failure, List<Reservation>>> listButCanceled() async {
    try {
      return Right(await datasource.listButCanceled());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Reservation>> retrieve(int id) async {
    try {
      return Right(await datasource.retrieve(id));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Reservation>> save(Reservation reservation) async {
    try {
      return Right(await datasource.save(reservation));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, bool>> checkIn(int id) async{

     try {
        return Right( await datasource.checkIn(id));
     } on ServerException catch (e) {
        return Left( Failure(e.message ));
     }
  }
  

}

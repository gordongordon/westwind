import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

abstract class RoomTransactionRepository {
  Future<Either<Failure, List<RoomTransaction>>> list();
  Future<Either<Failure, bool>> delete(int id);
  Future<Either<Failure, RoomTransaction>> retrieve(int id);
  Future<Either<Failure, RoomTransaction>> create(RoomTransaction roomTransaction);
}
 
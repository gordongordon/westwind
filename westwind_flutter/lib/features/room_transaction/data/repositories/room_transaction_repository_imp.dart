import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/features/room_transaction/data/datasources/room_transaction_datasource.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class RoomTransactionRepositoryImp implements RoomTransactionRepository {
  final RoomTransactionDatasource _datasource;

  const RoomTransactionRepositoryImp(this._datasource);

  @override
  Future<Either<Failure, List<RoomTransaction>>> list() async {
    try {
      return right(await _datasource.list());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      return right(await _datasource.delete(id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomTransaction>> retrieve(int id) async {
    try {
      return right(await _datasource.retrieve(id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomTransaction>> save(RoomTransaction roomTransaction) async {
    try {
      return right(await _datasource.save(roomTransaction));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<RoomTransaction>>> getTransactionsForRoomGuest(int roomGuesetId) async {
    try {
      return right(await _datasource.getTransactionsForRoomGuest(roomGuesetId));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

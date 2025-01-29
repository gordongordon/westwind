import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/room_transaction/data/datasources/room_transaction_datasource.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';

class RoomTransactionRepositoryImp implements RoomTransactionRepository {
  final RoomTransactionDatasource _datasource;

  const RoomTransactionRepositoryImp(this._datasource);

  @override
  Future<Either<Failure, List<RoomTransaction>>> list() async {
    try {
      final response = await _datasource.list();

      final result = response.map(_fromServer).toList();

      //   return right(await _datasource.list());
      return right(result);
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
      final data = await _datasource.retrieve(id);

      final result = _fromServer(data);

      //  return right(await _datasource.retrieve(id));
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RoomTransaction>> save(
      RoomTransaction roomTransaction) async {
    try {
      final result = _toServer(roomTransaction);

      //   return right(await _datasource.save(roomTransaction));
      return right(await _datasource.save(result));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<RoomTransaction>>> getTransactionsForRoomGuest(
      int roomGuesetId) async {
    try {
      final response =
          await _datasource.getTransactionsForRoomGuest(roomGuesetId);

      final result = response.map(_fromServer).toList();

      // return right(await _datasource.getTransactionsForRoomGuest(roomGuesetId));
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  RoomTransaction _toServer(RoomTransaction data) {
    return RoomTransaction(
      id: data.id,
      guestId: data.guestId,
      roomId: data.roomId,
      roomGuestId: data.roomGuestId,
      stayDay: TimeManager.instance.toServer(data.stayDay),
      transactionDay: TimeManager.instance.toServer(data.transactionDay),
      transactionType: data.transactionType,
      amount: data.amount,
      tax1: data.tax1,
      tax2: data.tax2,
      total: data.total,
      description: data.description,
      itemType: data.itemType,
      guest: data.guest,
      roomGuest: data.roomGuest,
      room: data.room,
      updateDate: data.updateDate != null
          ? TimeManager.instance.toServer(data.updateDate!)
          : null,
    );
  }

  RoomTransaction _fromServer(RoomTransaction data) {
    return RoomTransaction(
      id: data.id,
      guestId: data.guestId,
      roomId: data.roomId,
      roomGuestId: data.roomGuestId,
      stayDay: TimeManager.instance.fromServer(data.stayDay),
      transactionDay: TimeManager.instance.fromServer(data.transactionDay),
      transactionType: data.transactionType,
      amount: data.amount,
      tax1: data.tax1,
      tax2: data.tax2,
      total: data.total,
      description: data.description,
      itemType: data.itemType,
      guest: data.guest,
      roomGuest: data.roomGuest,
      room: data.room,
      updateDate: data.updateDate != null
          ? TimeManager.instance.fromServer(data.updateDate!)
          : null,
    );
  }
  
  @override
  Future<Either<Failure, List<RoomTransaction>>> getTransactionsForRoomGuestWithOutLaundry(int roomGuesetId) async {
    try {
      final response =
          await _datasource.getTransactionsForRoomGuestWithOutLaundry(roomGuesetId);

      final result = response.map(_fromServer).toList();

      // return right(await _datasource.getTransactionsForRoomGuest(roomGuesetId));
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

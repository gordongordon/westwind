import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract class RoomTransactionDatasource {
  Future<List<RoomTransaction>> list();
  Future<List<RoomTransaction>> listByDay(DateTime day);
  Future<RoomTransaction> retrieve(int id);
  Future<bool> delete(int id);
  Future<RoomTransaction> save(RoomTransaction roomTransaction);
  Future<List<RoomTransaction>> getTransactionsForRoomGuest(int roomGuestId);
  Future<List<RoomTransaction>> getTransactionsForRoomGuestOrderDescending(
      int roomGuestId, TransactionType? transactionType);
  Future<List<RoomTransaction>> getTransactionsForRoomGuestWithOutLaundry(
      int roomGuestId);
  Future<List<RoomTransaction>> findRoomTransactionsForWindow(
      DateTime startDate, DateTime endDate);
}

class RoomTransactionDatasourceImpl implements RoomTransactionDatasource {
  final Client _client;

  const RoomTransactionDatasourceImpl(this._client);

  @override
  Future<List<RoomTransaction>> list() async {
    try {
      return await _client.roomTransaction.list();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RoomTransaction> retrieve(int id) async {
    try {
      final result = await _client.roomTransaction.retrieve(id);

      if (result == null) {
        throw ServerException("Room Transaction not found");
      }
      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final result = await _client.roomTransaction.delete(id);

      if (result == false) {
        throw ServerException("Room Transaction can't be deleted");
      }
      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RoomTransaction> save(RoomTransaction roomTransaction) async {
    try {
      final result =
          await _client.roomTransaction.saveRoomTransaciton(roomTransaction);

      if (result.id == null) {
        throw ServerException("Room Transaction can't be created");
      }
      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomTransaction>> getTransactionsForRoomGuest(
      int roomGuestId) async {
    try {
      return await _client.roomTransaction
          .getTransactionsForRoomGuest(roomGuestId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomTransaction>> getTransactionsForRoomGuestWithOutLaundry(
      int roomGuestId) async {
    try {
      return await _client.roomTransaction
          .getTransactionsForRoomGuestWithOutLaundry(roomGuestId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomTransaction>> listByDay(DateTime day) async {
    try {
      return await _client.roomTransaction.listByDay(day);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomTransaction>> getTransactionsForRoomGuestOrderDescending(
    int roomGuestId,
    TransactionType? transactionType,
  ) async {
    try {
      return await _client.roomTransaction
          .getTransactionsForRoomGuestOrderDescending(
              roomGuestId, transactionType);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomTransaction>> findRoomTransactionsForWindow(
      DateTime startDate, DateTime endDate) async {
    try {
      return await _client.roomTransaction
          .findRoomTransactionsForWindow(startDate, endDate);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

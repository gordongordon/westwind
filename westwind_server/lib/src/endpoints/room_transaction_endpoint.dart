import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/src/generated/protocol.dart';

class RoomTransactionEndpoint extends Endpoint {
  Future<bool> hasBeenRoomChargedToday(Session session, int guestId) async {
    //  final today = DateTime.now();

    // if find all room charge by given GuestId
    final transactionHistory = await RoomTransaction.db.find(session,
        where: (item) =>
            item.guestId.equals(guestId) & item.itemType.equals(ItemType.room));

    return transactionHistory.any((transaction) {
      DateTime today = DateTime.now().toUtc();
      return transaction.transactionDay.year == today.year &&
          transaction.transactionDay.month == today.month &&
          transaction.transactionDay.day == today.day;
    });
  }

  Future<List<RoomTransaction>> list(Session session) async {
    return await RoomTransaction.db.find(session,
        orderByList: (t) => [
              Order(column: t.updateDate, orderDescending: true),
              Order(column: t.transactionDay, orderDescending: true),
            ],
        include: RoomTransaction.include(
            guest: Guest.include(),
            room: Room.include(),
            roomGuest: RoomGuest.include(
              guest: Guest.include(),
            )));
  }

  Future<List<RoomTransaction>> listWithItemTypeRoom(Session session) async {
    return await RoomTransaction.db.find(session,
        where: (i) => i.itemType.equals(ItemType.room),
        orderByList: (t) => [
              Order(column: t.updateDate, orderDescending: true),
              Order(column: t.transactionDay, orderDescending: true),
            ],
        include: RoomTransaction.include(
            guest: Guest.include(),
            room: Room.include(),
            roomGuest: RoomGuest.include(
              guest: Guest.include(),
            )));
  }

  Future<List<RoomTransaction>> getTransactionsForRoomGuest(
      Session session, int roomGuestId) async {
    return await RoomTransaction.db.find(session,
        where: (i) => i.roomGuestId.equals(roomGuestId),
      //  orderBy : (t)  => t.updateDate,
        orderByList: (t) => [
              Order(column: t.updateDate, orderDescending: true),
              Order(column: t.transactionDay, orderDescending: true),
            ],
        include: RoomTransaction.include(
            guest: Guest.include(),
            room: Room.include(),
            roomGuest: RoomGuest.include(
              guest: Guest.include(),
            )));
  }

  Future<RoomTransaction> saveRoomTransaciton(
      Session session, RoomTransaction rt) async {
    if (rt.id != null) {
      rt.updateDate = DateTime.now().toUtc();
      return await RoomTransaction.db.updateRow(session, rt);
    }
    return await RoomTransaction.db.insertRow(session, rt);
  }

/*  Future<RoomTransaction> save(Session session, RoomTransaction rt) async {

    
  //  var roomTransaction = await RoomTransaction.db.insertRow(session, rt);
  //  var roomGuest = await RoomGuest.db.findById(session, roomTransaction.roomGuestId );


  //  await RoomGuest.db.attachRow.roomTransactions(session, roomGuest!, roomTransaction );

 //   return roomTransaction;


       return await RoomTransaction.db.insertRow(session, rt);
  }
 */
  Future<RoomTransaction?> retrieve(Session session, int id) async {
    return await RoomTransaction.db.findFirstRow(session,
        where: (item) => item.id.equals(id),
        include: RoomTransaction.include(
            guest: Guest.include(),
            room: Room.include(),
            roomGuest: RoomGuest.include(
              guest: Guest.include(),
            )));
  }

  Future<bool> delete(Session session, int id) async {
    final rt = await RoomTransaction.db.findFirstRow(
      session,
      where: (item) => item.id.equals(id),
    );

    if (rt == null) {
      return false;
    }

    final result = await RoomTransaction.db.deleteRow(session, rt);

    if (result.id == id) {
      return true;
    }

    return false;
  }
}

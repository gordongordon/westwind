import 'package:westwind_server/src/generated/protocol.dart';
import 'package:westwind_server/src/generated/rateReason.dart';
import 'package:westwind_server/src/generated/roomGuest.dart';
import 'package:serverpod/serverpod.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class RoomGuestEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.

  Future<RoomGuest> createRoomGuest(Session session, RoomGuest res) async {
    return await RoomGuest.db.insertRow(session, res);
  }

  Future<RoomGuest?> findRoomGuest(Session session,
      {required int roomGuestId}) async {
    RoomGuest? res = await RoomGuest.db.findById(session, roomGuestId);

    //   RoomGuest.db.findFirstRow(session,
    //   where: (t) => t.id.equals(RoomGuestId),
    // );
    return res;
  }

  Future<bool> updateRoomGuest(Session session,
      {required RoomGuest roomGuest}) async {
    await RoomGuest.db.updateRow(session, roomGuest);
    return true;
  }

  Future<List<RoomGuest>> findRoomGuestByRoomId(Session session,
      {required int id}) async {
    return await RoomGuest.db.find(session,
        where: (roomGuest) => roomGuest.roomId.equals(id),
        include: RoomGuest.include(
          guest: Guest.include(),
          room: Room.include(),
        ));
  }

  Future<List<RoomGuest>> getAllRoomGuest(Session session) async {
    return await RoomGuest.db.find(session,
        orderBy: (t) => t.roomId,
        include: RoomGuest.include(
          guest: Guest.include(company: Company.include()),
          room: Room.include(),
          reservation: Reservation.include(),
        ));
  }

  Future<List<RoomGuest>> getAllRoomGuestByDay(
      Session session, DateTime datetime) async {
    return await RoomGuest.db.find(session,
        where: (t) => t.stateDate.between(
            datetime.subtract(const Duration(days: 1)),
            datetime.add(const Duration(days: 1))));
  }

  Future<List<RoomGuest>> getTodayRoomGuest(Session session) async {
    final DateTime now = DateTime.now();
    return await getAllRoomGuestByDay(session, now);
  }

  Future<int> updateRateReasonSingle(Session session,
      {required RateReason rateReason}) async {
    return 0;
  }

  Future<int> updateRateReasonShare(Session session,
      {required RateReason rateReason}) async {
    return 0;
  }

  Future<int> updateRateReasonDoulbe(Session session,
      {required RateReason rateReason}) async {
    return 0;
  }

  Future<int> updateRateReasonGoHome(Session session,
      {required RateReason rateReason}) async {
    return 0;
  }

  Future<int> updateRateReasonOther(Session session,
      {required RateReason rateReason}) async {
    return 0;
  }

  Future<List<RoomGuest>> findRoommates(Session session,
      {required RoomGuest roomGuest}) async {
    final roomGuests = await RoomGuest.db.find(
      session,
      // roommates with the room id , but not the deleted guest.id
      where: (t) =>
          (t.roomId.equals(roomGuest.roomId)) &
          (t.guestId.notEquals(roomGuest.guestId)),
    );

    if (roomGuests.length >= 3) {
      final roomId = roomGuest.id;
      throw MyException(
          message: 'Roommates found more then 3 in RoomId $roomId',
          errorType: ErrorType.TooManyRoommates);
    }

    return roomGuests;
  }

  Future<double> getRate(Session session,
      {required RoomGuest roomGuest}) async {
    final rateTable = await RateTable.db.findFirstRow(
      session,
      where: (item) =>
          item.rateType.equals(roomGuest.rateType) &
          item.rateReason.equals(roomGuest.rateReason),
    );

    if (rateTable == null) {
      final type = roomGuest.rateType;
      final reason = roomGuest.rateReason;
      throw MyException(
          message:
              'Reservation RateTable miss match rateType.$type and rateReason.$reason',
          errorType: ErrorType.NotFound);
    }

    return rateTable.rate;
  }

  Future<RoomGuest?> findById(Session session, {required int id}) async {
    return await RoomGuest.db.findById(session, id);
  }

  Future<List<int>> delete(Session session, {required int id}) async {
    //  return await RoomGuest.db.deleteWhere(session, roomGuest);
    // return await RoomGuest.delete(session, where: where).delete(session, rows)
    return await RoomGuest.db
        .deleteWhere(session, where: (item) => item.id.equals(id));

    //  return await RoomGuest.db.deleteRow(session, roomGuest);
  }

  /*  Replace with CheckOut
  Future<int> delete(Session session, {required int id}) async {
    final roomGuest = await RoomGuest.db.findById(session, id);

    if (roomGuest == null) return 0;

    final roommates = await findRoommates(
      session,
      roomGuest: roomGuest,
    );

    //
     // if empty, checkin  with default rate of single
    //
    if (roommates.isEmpty) {
      print('No Roommates');
      return await RoomGuest.db.deleteRow(session, roomGuest);
    } else {
      // Chnage roomate back to single
      roommates.first.rateReason = RateReason.single;
      roommates.first.rate = await getRate(session, roomGuest: roommates.first);

      final num = roommates.length;
      print('Number of Roommates $num');
      var result = session.dbNext.transaction((transaction) async {
        // Do some database queries here.
        //
        // update an roommate share and rate 
        //
        // Update exited roommates to Share and rate
        await RoomGuest.db.updateRow(session, roommates.first);

        return await RoomGuest.db.deleteRow(session, roomGuest);
      });

      return result;
    }
  }

  */

  Future<int> checkOut(Session session,
      {required RoomGuest roommate, required RoomGuest roomGuest}) async {
    var result = await session.dbNext.transaction((transaction) async {
      // Do some database queries here.
      /*
        * update an roommate share and rate 
        */
      // Update exited roommates to Share and rate
      await RoomGuest.db.updateRow(session, roommate);

      return await RoomGuest.db.deleteRow(session, roomGuest);
    });

    return result;
  }

  Future<RoomGuest> updateGuestRate(Session session,
      {required int id, required double rate}) async {
    final roomGuest = await RoomGuest.db.findById(session, id);

    roomGuest!.rate = rate;

    return await RoomGuest.db.updateRow(session, roomGuest);
  }
}

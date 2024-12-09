import 'package:westwind_server/src/generated/protocol.dart';
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

  Future<RoomGuest> saveRoomGuest(Session session, RoomGuest res) async {
    if ( res.id != null) {
      res.updateDate = DateTime.now().toLocal();
      return await RoomGuest.db.updateRow(session, res);
    }

    
    return await RoomGuest.db.insertRow(session, res);
  }



  Future<RoomGuest> insertGuestByReservation(
      Session session,
      RoomGuest checkInGuest,
      Reservation reservation) async {

    final result =
        await session.db.transaction<RoomGuest>((transaction) async {

      reservation.isCheckedIn = true;
      await Reservation.db.updateRow(session, reservation);
      // Insert New Room Guest
      return await RoomGuest.db.insertRow(session, checkInGuest);
    });

    if (result == false) {
      final id = reservation.id!;
      throw MyException(
          message: "Guest can't be checked with reservation id $id",
          errorType: ErrorType.ProblemOfInsert);
    }
    return result;
  }


/*
  Future<RoomGuest> createRoomGuestByReservation(
      Session session,
      RoomGuest checkInGuest,
      List<RoomGuest> roommates,
      Reservation reservation) async {

    final result =
        await session.dbNext.transaction<RoomGuest>((transaction) async {
      await RoomGuest.db.update(session, roommates);

      reservation.isCheckedIn = true;
      await Reservation.db.updateRow(session, reservation);
      // Insert New Room Guest
      return await RoomGuest.db.insertRow(session, checkInGuest);
    });

    if (result == false) {
      final id = reservation.id!;
      throw MyException(
          message: "Guest can't be checked with reservation id $id",
          errorType: ErrorType.ProblemOfInsert);
    }
    return result;
  }
*/

  Future<List<RoomGuest>> changeAllRateByRoomId(
      Session session, int id, double rate) async {
    final List<RoomGuest> result = await RoomGuest.db
        .find(session, where: (item) => item.roomId.equals(id));

    result.map((e) {
      e.rate = rate;
      return e;
    }).toList();

    return RoomGuest.db.update(session, result);
  }

  Future<List<RoomGuest>> changeAllRateReasonByRoomId(
      Session session, int id, RateReason reason) async {
    final List<RoomGuest> result = await RoomGuest.db
        .find(session, where: (item) => item.roomId.equals(id));

    result.map((e) {
      e.rateReason = reason;
      return e;
    }).toList();

    return RoomGuest.db.update(session, result);
  }

  Future<RoomGuest?> findRoomGuest(Session session,
      {required int roomGuestId}) async {
    RoomGuest? res = await RoomGuest.db.findById(session, 
            roomGuestId,
            include: RoomGuest.include(
             guest : Guest.include(),
          )
          
          );

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

  Future<List<RoomGuest>> updateRoomGuests( Session session, { required List<RoomGuest> roomGuests }) async {

       return await RoomGuest.db.update(session, roomGuests);

  }

  Future<List<RoomGuest>> findRoomGuestByRoomId   (Session session,
      {required int id}) async {
    return await RoomGuest.db.find(session,
        where: (roomGuest) => roomGuest.roomId.equals(id),
        include: RoomGuest.include(
          guest: Guest.include(),
          room: Room.include(),
        ));
  }


  Future<List<RoomGuest>> retrieveRoommatesSameStayDayWithOutGoHomeById(Session session,
      {required int id}) async {
  
    
    final roomGuest = await RoomGuest.db.findById(session, id);

  //  int roomId = 0;
        print( "retrieveRoommatesSameStayDaybyId $roomGuest");
    if ( roomGuest == null || roomGuest.id == null ) {
        print( "retrieveRoommatesSameStayDaybyId return []");
        return [];
    }

    final roomId = roomGuest.roomId; 
    final roomGuestId = roomGuest.id;
    final stayDay = roomGuest.stayDay;

    final result = await RoomGuest.db.find(session,
        where: (roomGuest) => roomGuest.roomId.equals(roomId) & roomGuest.stayDay.equals(stayDay) & roomGuest.rateReason.notEquals(RateReason.gohome),
        include: RoomGuest.include(
          guest: Guest.include(),
          room: Room.include(),
        ));
     
   final size = result.length;
   print( "retrieveRoommatesSameStayDaybyId size $size");
    return result;
  }


  Future<List<RoomGuest>> updateRateSameStayDayByReasonAndId(Session session, int id, RateReason reason, double rate) async {
    
        final roomGuest = await RoomGuest.db.findById(session, id);

  //  int roomId = 0;
        print( "updateRateSameStayDayByReasonAndId $roomGuest");
    if ( roomGuest == null || roomGuest.id == null ) {
        print( "updateRateSameStayDayByReasonAndId return []");
        return [];
    }

    final roomId = roomGuest.roomId; 
    final roomGuestId = roomGuest.id;
    final stayDay = roomGuest.stayDay;

    final roommates = await RoomGuest.db.find(session,
        where: (roomGuest) => roomGuest.roomId.equals(roomId) & roomGuest.stayDay.equals(stayDay) & roomGuest.rateReason.equals(reason),
        include: RoomGuest.include(
          guest: Guest.include(),
          room: Room.include(),
        ));
     
  
   final result =  roommates.map((roomGuest) => roomGuest..rate = 0).toList();

   final size = roommates.length;
   print( "updateRateSameStayDayByReasonAndId size $size");

    RoomGuest.db.update(session, result);
    return result;
  }  



  /**
   * Note: retrieve roommate but checkout
   */
  Future<List<RoomGuest>> retrieveRoommatesSameStayDayById(Session session,
      {required int id}) async {
  
    
    final roomGuest = await RoomGuest.db.findById(session, id);

  //  int roomId = 0;
        print( "retrieveRoommatesSameStayDaybyId $roomGuest");
    if ( roomGuest == null || roomGuest.id == null ) {
        print( "retrieveRoommatesSameStayDaybyId return []");
        return [];
    }

    final roomId = roomGuest.roomId; 
    final roomGuestId = roomGuest.id;
    final stayDay = roomGuest.stayDay;

    final result = await RoomGuest.db.find(session,
        where: (roomGuest) => roomGuest.roomId.equals(roomId) & roomGuest.stayDay.equals(stayDay) & roomGuest.isCheckOut.equals(false),
        include: RoomGuest.include(
          guest: Guest.include(),
          room: Room.include(),
        ));
     
   final size = result.length;
   print( "retrieveRoommatesSameStayDaybyId size $size");
    return result;
  }



  Future<List<RoomGuest>> getAllRoomGuest(Session session) async {
    return await RoomGuest.db.find(session,
        //orderBy: (t) => t.roomId,
        orderByList: (t) => [
          Order( column: t.updateDate, orderDescending: true),
          Order( column: t.roomId, orderDescending : true),
          Order( column: t.stayDay, orderDescending: false),
          Order( column: t.checkOutDate, orderDescending: false),
          Order( column: t.guest.lastName, orderDescending: false),
        ],
       // where: (t) => t.isCheckOut.equals(false),
        include: RoomGuest.include(
          guest: Guest.include(company: Company.include()),
          room: Room.include(),
          reservation: Reservation.include(),
          roomTransactions: RoomTransaction.includeList(),
        ));
  }

  Future<List<RoomGuest>> getAllRoomGuestButCheckOut(Session session) async {
    return await RoomGuest.db.find(session,
        //orderBy: (t) => t.roomId,
        orderByList: (t) => [
          Order( column: t.updateDate, orderDescending: true),
          Order( column: t.roomId, orderDescending : true),
          Order( column: t.stayDay, orderDescending: false),
          Order( column: t.checkOutDate, orderDescending: false),
          Order( column: t.guest.lastName, orderDescending: false),
        ],
        where: (t) => t.isCheckOut.equals(false),
        include: RoomGuest.include(
          guest: Guest.include(company: Company.include()),
          room: Room.include(),
          reservation: Reservation.include(),
          roomTransactions: RoomTransaction.includeList(),
        ));
  }


  Future<List<RoomGuest>> getAllRoomGuestByDay(
      Session session, DateTime datetime) async {
    return await RoomGuest.db.find(session,
        where: (t) => t.stayDay.between(
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
    return await RoomGuest.db.findById(session, id, 
            include: RoomGuest.include(
          guest: Guest.include(),
          room: Room.include(),
                    roomTransactions: RoomTransaction.includeList(),
        ));
  }

  Future<List<RoomGuest>> delete(Session session, {required int id}) async {
    //  return await RoomGuest.db.deleteWhere(session, roomGuest);
    // return await RoomGuest.delete(session, where: where).delete(session, rows)
    return await RoomGuest.db
        .deleteWhere(session, where: (item) => item.id.equals(id));

    //  return await RoomGuest.db.deleteRow(session, roomGuest);
  }

  Future<bool> deleteById(Session session, int id) async {
    final item = await RoomGuest.db.findById(session, id);

    if (item == null) {
      return false;
    }

    final result = await RoomGuest.db.deleteRow(session, item);

    if (result == id) {
      return true;
    }

    return false;
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

  Future<RoomGuest> checkOut(Session session,
      {required RoomGuest roommate, required RoomGuest roomGuest}) async {
    var result = await session.db.transaction((transaction) async {
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

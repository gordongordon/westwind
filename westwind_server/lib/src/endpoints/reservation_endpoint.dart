import 'package:westwind_server/src/core/MyExtension.dart';
import 'package:westwind_server/src/endpoints/rate_Table_endpoint.dart';
import 'package:westwind_server/src/endpoints/room_guest_endpoint.dart';
import 'package:westwind_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class ReservationEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.

  //Future<Reservation?> retrieve(Session session, int id) async {
  //  return Reservation.db.findById(session, id);
  // }

  Future<Reservation> save(Session session, Reservation reservation) async {
    if (reservation.id != null) {
     // if ( reservation.isCheckedIn ) {
         // check day can't change
       //  final result = await Reservation.db.findById(session, reservation.id! );
       //  if ( result!= null ) {
       //       final diffDay = reservation.checkOutDate.day - reservation.checkInDate.day;
       //       reservation.checkInDate = result.checkInDate;
       //       reservation.checkOutDate = result.checkInDate
       //  }
      //}

      reservation.dateUpdate = DateTime.now().toLocal();
      return await Reservation.db.updateRow(session, reservation);
    } else {
      reservation.dateCreate = DateTime.now().toLocal();
      reservation.checkInDate.getDateOnly();
      reservation.stayDay.getDateOnly();
      reservation.checkOutDate.getDateOnly();
      return Reservation.db.insertRow(session, reservation);
    }
  }
/*
  Future<Reservation> createReservation(
      Session session, Reservation res) async {
    final rateTable = await RateTable.db.findFirstRow(
      session,
      where: (item) =>
          item.rateType.equals(res.rateType) &
          item.rateReason.equals(res.rateReason),
    );

    if (rateTable != null) {
      res.rate = rateTable.rate;
    }

       res.checkInDate.getDateOnly();
      res.checkOutDate.getDateOnly();
    // Null check

    return await Reservation.db.insertRow(session, res);
  }
*/

  Future<Reservation?> retrieve(Session session, {required int id}) async {
    final res = await Reservation.db.findById(session, id,
  
        include: Reservation.include(
          guest: Guest.include(),
          room: Room.include(),
        ));

    print("reservation = $res");

    return res;
  }

  Future<Reservation> cancelReservation(Session session,
      {required int id}) async {
    final reservation = await Reservation.db.findById(session, id);

    if (reservation != null) {
      reservation.isCanceled = true;
      reservation.dateUpdate = DateTime.now();
      return await Reservation.db.updateRow(session, reservation);
    }

    print('cancel Reservation id $id');

    return reservation!;
  }

  Future<bool> updateReservation(Session session,
      {required Reservation reservation}) async {
    reservation.dateUpdate = DateTime.now();

    final res = await Reservation.db.updateRow(session, reservation);

    print('updated Reservation $res');

    return true;
  }

  Future<List<Reservation>> findReservationById(Session session,
      {required int id}) async {
    return await Reservation.db.find(
      session,
      where: (reservation) => reservation.id.equals(id),
      include: Reservation.include(
        guest: Guest.include(),
        room: Room.include(),
      ),
    );
  }

  Future<List<Reservation>> list(Session session) async {
    return await Reservation.db.find(
      session,
      limit: 20,
     where: (reservation) => reservation.isCheckedIn.equals(false),
      include: Reservation.include(
        guest: Guest.include(),
        room: Room.include(),
      ),
      orderByList: (t) => [
        Order(column: t.isCheckedIn, orderDescending: false),
        Order(column: t.id, orderDescending: true),
        Order(column: t.checkInDate),
      ],
    );
  }

/*
  Future<List<Reservation>> getNullCheckInReservations(Session session) async {
    return await Reservation.db.find(
      session,
      limit: 20,
      include: Reservation.include(
        guest: Guest.include(),
        room: Room.include(),
      ),
      orderByList: (t) => [
        Order(column: t.isCheckedIn, orderDescending: false),
        Order(column: t.id, orderDescending: true),
        Order(column: t.checkInDate),
      ],
      // orderBy: (t) => t.id,
      //orderDescending: true,
      where: (item) => item.isCheckedIn.notEquals(true),
    );
  }
*/

/*
  Future<List<Reservation>> getAllReservationsByDay(
      Session session, DateTime datetime) async {
    return await Reservation.db.find(session,
        where: (t) => t.checkInDate.between(
              datetime.subtract(
                const Duration(days: 1),
              ),
              datetime.add(
                const Duration(days: 1),
              ),
            ),
        include: Reservation.include(
          guest: Guest.include(),
          room: Room.include(),
        ));
  }

  Future<List<Reservation>> getTodayReservations(Session session) async {
    final DateTime now = DateTime.now();
    return await getAllReservationsByDay(
      session,
      now,
    );
  }

*/
  Future<bool> checkIn(Session session, {required int reservationId}) async {
    // get the reservation to be checked in
    final reservation = await Reservation.db.findById(session, reservationId);

    if (reservation == null) {
      final id = reservationId;
      throw MyException(
          message: 'ReservationId not found $id during Check In',
          errorType: ErrorType.NotFound);
    }

    reservation.checkInDate = DateTime.now().getDateOnly();

    final roomGuest = createRoomGuest(reservation);

    reservation.isCheckedIn = true;
    await Reservation.db.updateRow(session, reservation);
    // Insert New Room Guest
    final result = await RoomGuest.db.insertRow(session, roomGuest);

    if (result.id != null) {
      return true;
    }

    return false;
  }

  RoomGuest createRoomGuest(Reservation reservation) {
    
    final roomGuest = RoomGuest(
      roomId: reservation.roomId,
      stayDate: reservation.checkInDate,
      guestId: reservation.guestId,
   //   roomTransactions: null,
      rateType: reservation.rateType,
      rateReason: RateReason.single,
      rate: reservation.rate,
      reservationId: reservation.id!,
      roomStatus: RoomStatus.make,
      checkInDate : DateTime.now(),
      checkOutDate: reservation.checkOutDate,
      isCheckOut : false,
    );

    return roomGuest;
  }

//! guest retrieveRoommateRoomGuest( roomid )
//! rate getSingleRate( rateType )
//! roomguest craeatRoomGuest( reservation )
//! bool toggleReservationIsCheck( id );
//! rate getShareRate( rateType )
//!      changeRoomGuestShareRate
  //
  //   Check In Reservation
  //   update all rateReason and rate
  //
  /* 
  Future<bool> checkInReservation(Session session,
      {required int reservationId}) async {
    // get the reservation to be checked in
    final reservation = await Reservation.db.findById(session, reservationId);

    if (reservation == null) {
      final id = reservationId;
      throw MyException(
          message: 'ReservationId not found $id during Check In',
          errorType: ErrorType.NotFound);
    }

    final roommates = await RoomGuestEndpoint()
        .findRoomGuestByRoomId(session, id: reservation.roomId);

    final RoomGuest roomGuest;

    final bool result;

    /**
     * if empty, checkin  with default rate of single
     */
    if (roommates.isEmpty) {
      final rate = await RateTableEndpoint()
          .getSingleRate(session, type: reservation.rateType);
      /**
        * create RoomGuest, and guest is alway single 
        */
      roomGuest = RoomGuest(
        roomId: reservation.roomId,
        stayDate: reservation.checkInDate,
        guestId: reservation.guestId,
        rateType: reservation.rateType,
        rateReason: RateReason.single,
        rate: rate,
        reservationId: reservation.id!,
        roomStatus: RoomStatus.make,
        checkInDate: DateTime.now(),
        checkOutDate: reservation.checkOutDate,
        isCheckOut: false,
      );

      result = await session.dbNext.transaction((transaction) async {
        // Do some database queries here.
        await RoomGuest.db.insertRow(session, roomGuest);
        reservation.isCheckedIn = true;
        await Reservation.db.updateRow(session, reservation);
        // Optionally return a value.
        return true;
      });
    } else {
      /**
       * Get rateTable to be computed for rate
       */
      final rateTable = await RateTable.db.findFirstRow(
        session,
        where: (item) =>
            item.rateType.equals(reservation.rateType) &
            item.rateReason.equals(RateReason.share),
      );

      if (rateTable == null) {
        final type = reservation.rateType;
        throw MyException(
            message:
                'Reservation RateTable not found rateType.$type and rateReason.share',
            errorType: ErrorType.NotFound);
      }

      /*
      * Create RoomGuest with Share and share rate.
      */
      roomGuest = RoomGuest(
        roomId: reservation.roomId,
        stayDate: reservation.checkInDate,
        guestId: reservation.guestId,
        rateType: reservation.rateType,
        rateReason: RateReason.share,
        rate: rateTable.rate,
        reservationId: reservation.id!,
        roomStatus: RoomStatus.make,
        checkInDate:  DateTime.now(),
        checkOutDate: reservation.checkOutDate,
        isCheckOut : false,
      );

      result = await session.dbNext.transaction((transaction) async {
        // Do some database queries here.
        /*
        * update an roommate share and rate 
        */
        roommates.first.rateReason = RateReason.share;
        roommates.first.rate = rateTable.rate;
        // Update exited roommates to Share and rate
        await RoomGuest.db.updateRow(session, roommates.first);
        // Insert New Room Guest
        await RoomGuest.db.insertRow(session, roomGuest);

        reservation.isCheckedIn = true;
        await Reservation.db.updateRow(session, reservation);
        // Optionally return a value.
        return true;
      });
    }

    return result;
  }

  */

  Future<bool> delete(Session session, int id) async {
    final reservation = await Reservation.db.findById(session, id);

    if (reservation == null) {
      return false;
    }

    final result = await Reservation.db.deleteRow(session, reservation);

    if (result == id) {
      return true;
    }

    return false;
  }
  

/*
  Future<bool> checkInReservationSecondVersion(Session session,
      {required int reservationId}) async {
    // get the reservation to be checked in
    final reservation = await Reservation.db.findById(session, reservationId);

    if (reservation == null) {
      final id = reservationId;
      throw MyException(
          message: 'ReservationId not found $id',
          errorType: ErrorType.NotFound);
    }

    // get the room id to find out any roommate
    final roomId = reservation.roomId;

    // find out are there any roomate with the same roomId
    // final roommates = await RoomGuest.db.find(session,
    //     where: (roomGuest) => roomGuest.roomId.equals(roomId),
    //      include: RoomGuest.include(
    //        guest: Guest.include(),
    //       room: Room.include(),
    //    ));

    final roommates =
        await RoomGuestEndpoint().findRoomGuestByRoomId(session, id: roomId);

    final RoomGuest roomGuest;

    final bool result;

    /**
     * if empty, checkin  with default rate of single
     */
    if (roommates.isEmpty) {
      //  final rate = await RateTableEndpoint().getSingleRate(session, type: reservation.rateType);

      final rateTable = await RateTable.db.findFirstRow(
        session,
        where: (item) =>
            item.rateType.equals(reservation.rateType) &
            item.rateReason.equals(RateReason.single),
      );

      /**
        * create RoomGuest, and guest is alway single 
        */
      roomGuest = RoomGuest(
        roomId: reservation.roomId,
        stayDate: reservation.checkInDate,
        guestId: reservation.guestId,
        rateType: reservation.rateType,
        rateReason: RateReason.single,
        rate: rateTable!.rate,
        reservationId: reservation.id!,
        roomStatus: RoomStatus.make,
        checkInDate:  DateTime.now(),
        checkOutDate: reservation.checkOutDate,
        isCheckOut : false,
      );

      result = await session.dbNext.transaction((transaction) async {
        // Do some database queries here.
        await RoomGuest.db.insertRow(session, roomGuest);
        reservation.isCheckedIn = true;
        await Reservation.db.updateRow(session, reservation);
        // Optionally return a value.
        return true;
      });
    } else {
      /**
       * Get rateTable to be computed for rate
       */
      final rateTable = await RateTable.db.findFirstRow(
        session,
        where: (item) =>
            item.rateType.equals(reservation.rateType) &
            item.rateReason.equals(RateReason.share),
      );

      if (rateTable == null) {
        final type = reservation.rateType;
        throw MyException(
            message:
                'Reservation RateTable not found rateType.$type and rateReason.share',
            errorType: ErrorType.NotFound);
      }

      /*
      * Create RoomGuest with Share and share rate.
      */
      roomGuest = RoomGuest(
        roomId: reservation.roomId,
        stayDate: reservation.checkInDate,
        guestId: reservation.guestId,
        rateType: reservation.rateType,
        rateReason: RateReason.share,
        rate: rateTable.rate,
        reservationId: reservation.id!,
        roomStatus: RoomStatus.make,
        checkInDate:  DateTime.now(),
        checkOutDate: reservation.checkOutDate,
        isCheckOut : false,
      );

      result = await session.dbNext.transaction((transaction) async {
        // Do some database queries here.
        /*
        * update an roommate share and rate 
        */
        roommates.first.rateReason = RateReason.share;
        roommates.first.rate = rateTable.rate;
        // Update exited roommates to Share and rate
        await RoomGuest.db.updateRow(session, roommates.first);
        // Insert New Room Guest
        await RoomGuest.db.insertRow(session, roomGuest);

        reservation.isCheckedIn = true;
        await Reservation.db.updateRow(session, reservation);
        // Optionally return a value.
        return true;
      });
    }

    return result;
  }
  */
}

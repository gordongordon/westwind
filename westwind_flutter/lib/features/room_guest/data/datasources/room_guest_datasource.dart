import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class RoomGuestDatasource {
  Future<List<RoomGuest>> list();
  Future<List<RoomGuest>> listButCheckOut();
  Future<RoomGuest> save(RoomGuest roomGuest);
  Future<bool> delete(int id);
  Future<RoomGuest> retrieve(int id);
  Future<bool> hasRoomate(int roomId);
  Future<List<RoomGuest>> retrieveByRoomId(int roomId);
  Future<RoomGuest> checkInRoomGuest(
      {required RoomGuest checkInRoomGuest, required Reservation reservation});
//  Future<RoomGuest> checkInRoomGuest( {required RoomGuest checkInRoomGuest, required List<RoomGuest> roommates, required Reservation reservation } );
  Future<List<RoomGuest>> update({required List<RoomGuest> roomGuests});
  Future<List<RoomGuest>> retrieveRoommatesSameStayDayById(int roomGuestId);
  Future<List<RoomGuest>> retrieveRoommatesSameStayDayWithOutGoHomeById( int roomGuestId );
  Future<List<RoomGuest>> updateRateSameStayDayByReasonAndId( int roomGuestId, RateReason rearson, double rate); 
  Future<RoomGuest?> updateNote( {required int roomGuestId, required String note}); 
  Future<List<RoomGuest>> findRoomGuestsForWindow(DateTime startDate, DateTime endDate);

}

class RoomGuestDatasourceImpl implements RoomGuestDatasource {
  Client client;

  RoomGuestDatasourceImpl(this.client);

  @override
  Future<bool> delete(int id) async {
    try {
      final result = await client.roomGuest.deleteById(id);

      if (result == false) {
        throw ServerException("RoomGuest with id $id can't be deleted");
      }

      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RoomGuest> retrieve(int id) async {
    try {
      final result = await client.roomGuest.findById(id: id);

      if (result == null) {
        throw ServerException("RoomGuest with $id wasn't found!");
      }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RoomGuest> save(RoomGuest roomGuest) async {
    try {
      return await client.roomGuest.saveRoomGuest(roomGuest);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> hasRoomate(int id) async {
    try {
      final result = await client.roomGuest.findRoomGuestByRoomId(id: id);

      if (result.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomGuest>> retrieveByRoomId(int roomId) async {
    try {
      return await client.roomGuest.findRoomGuestByRoomId(id: roomId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RoomGuest>> list() async {
    try {
      return await client.roomGuest.getAllRoomGuest();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  @override
  Future<List<RoomGuest>> listButCheckOut() async {
    try {
      return await client.roomGuest.getAllRoomGuestButCheckOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RoomGuest> checkInRoomGuest(
      {required RoomGuest checkInRoomGuest,
      required Reservation reservation}) async {
    try {
      return await client.roomGuest
          .insertGuestByReservation(checkInRoomGuest, reservation);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

/*  
 * Check In with roommate 
    @override
  Future<RoomGuest> checkInRoomGuest( {required RoomGuest checkInRoomGuest, required List<RoomGuest> roommates, required Reservation reservation } ) async {
             try {
         return await client.roomGuest.createRoomGuestByReservation( checkInRoomGuest, roommates, reservation);
      } catch (e) {
        throw ServerException(e.toString());
      }
  }
  */

  @override
  Future<List<RoomGuest>> update({required List<RoomGuest> roomGuests}) async {
    try {
      return await client.roomGuest.updateRoomGuests(roomGuests: roomGuests);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<RoomGuest>> retrieveRoommatesSameStayDayById(int roomGuestId) async {
    try {
      return await client.roomGuest.retrieveRoommatesSameStayDayById(id: roomGuestId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }


  @override
  Future<List<RoomGuest>> retrieveRoommatesSameStayDayWithOutGoHomeById(int roomGuestId) async {
    try {
      return await client.roomGuest.retrieveRoommatesSameStayDayWithOutGoHomeById(id: roomGuestId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<RoomGuest>> updateRateSameStayDayByReasonAndId(int roomGuestId, RateReason reason, double rate) async {
    try {
      return await client.roomGuest.updateRateSameStayDayByReasonAndId(roomGuestId, reason, rate );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<RoomGuest?> updateNote({required int roomGuestId, required String note}) async {
    try {
      return await client.roomGuest.updateNote( roomGuestId, note );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<RoomGuest>> findRoomGuestsForWindow(DateTime startDate, DateTime endDate) async {
    try {
      final result = await client.roomGuest.findRoomGuestsForWindow(startDate, endDate);

    /// if (result == null) {
     //   throw ServerException("RoomGuest with $id wasn't found!");
     // }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  
}

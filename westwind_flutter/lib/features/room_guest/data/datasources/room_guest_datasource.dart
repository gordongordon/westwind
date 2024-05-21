import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class RoomGuestDatasource {

  Future<List<RoomGuest>> list();
  Future<RoomGuest> save(RoomGuest roomGuest);
  Future<bool> delete( int id);
  Future<RoomGuest>  retrieve( int id);
  Future<bool> hasRoomate( int roomId );
  Future<List<RoomGuest>> retrieveByRoomId( int roomId );
  Future<RoomGuest> checkInRoomGuest( {required RoomGuest checkInRoomGuest, required List<RoomGuest> roommates, required Reservation reservation } );

}

class RoomGuestDatasourceImp implements RoomGuestDatasource {
  Client client;

  RoomGuestDatasourceImp( {required this.client});
  
  @override
  Future<bool> delete(int id) async {

      try {
         final result = await client.roomGuest.deleteById(  id);

         if ( result == false ) {
           throw ServerException("RoomGuest with id $id can't be deleted");
         }

         return true;

      } catch( e) {
        throw ServerException( e.toString() );
      }

  }
  
  @override
  Future<RoomGuest> retrieve(int id) async {
      try {
         final result = await client.roomGuest.findById(id: id);

         if ( result == null ) {
           throw ServerException("RoomGuest with $id wasn't found!");
         }

         return result;

      } catch (e) {
        throw ServerException( e.toString() );
      }
  }
  
  @override
  Future<RoomGuest> save(RoomGuest roomGuest) async {

          try {
         return await client.roomGuest.createRoomGuest(roomGuest);

      } catch (e) {
        throw ServerException(e.toString());
      }
  }
  
  @override
  Future<bool> hasRoomate(int id) async {
      try {
         final result = await client.roomGuest.findRoomGuestByRoomId(id: id);

         if ( result.isEmpty ) {
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
  Future<RoomGuest> checkInRoomGuest( {required RoomGuest checkInRoomGuest, required List<RoomGuest> roommates, required Reservation reservation } ) async {
             try {
         return await client.roomGuest.createRoomGuestByReservation( checkInRoomGuest, roommates, reservation);
      } catch (e) {
        throw ServerException(e.toString());
      }
  }
  

}

import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class RoomDatasource {
  Future<List<Room>> list();
  Future<Room> retrieve( int id);
  Future<Room> toggleRoomStatus( int roomId);
}

class RoomDatasourceImpl implements RoomDatasource {
  final Client _client;

  const RoomDatasourceImpl( this._client );

  // final SessionManager sessionManager;

  @override
  Future<List<Room>> list() async {
    try { 
     return await _client.room.list();
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }

  @override
  Future<Room> retrieve(int id) async {
    try { 
      final result = await _client.room.retrieve(id);

      if ( result == null)  {
        throw  ServerException("Room with ID : $id not found ");
      }
      return result;
        
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }

    @override
  Future<Room> toggleRoomStatus(int roomId) async {
    try { 
      final result = await _client.room.toggleRoomStatus(roomId);

      if ( result == null)  {
        throw  ServerException("Room with ID : $roomId not found ");
      }
      return result;
        
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }
}
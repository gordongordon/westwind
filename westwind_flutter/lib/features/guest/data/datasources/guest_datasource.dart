
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class GuestDatasource {
  Future<List<Guest>> list();
  Future<Guest> retrieve( int id);
}

class GuestDatasourceImpl implements GuestDatasource {
  final Client client;

  const GuestDatasourceImpl( this.client );

  // final SessionManager sessionManager;

  @override
  Future<List<Guest>> list() async {
    try { 
     return await client.guest.list();
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }

  @override
  Future<Guest> retrieve(int id) async {
    try { 
      final result = await client.guest.retrieve(id);

      if ( result == null)  {
        throw const ServerException("Guest not found");
      }
      return result;
        
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }
  
}
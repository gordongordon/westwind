
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';

abstract interface class GuestDatasource {
  Future<List<Guest>> list();
  Future<Guest> retrieve( int id);
  Future<Guest> create(Guest guest);
  Future<bool> delete( int id);
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
        throw  ServerException("Guest with ID : $id not found ");
      }
      return result;
        
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }

    @override
  Future<Guest> create(Guest guest) async {
    try { 
      final result = await client.guest.createGuest(guest: guest);

      if ( result.id == null )  {
        throw  ServerException("Guest can't be created!");
      }
      return result;
        
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }
  
  @override
  Future<bool> delete(int id) async {
    try { 
      final result = await client.guest.delete( id );

      if ( result == false )  {
        throw  ServerException("Guest can't be delete $id !");
      }
      return result;
        
    } catch (e) {
      throw ServerException( e.toString() );
    }
  }
  
}
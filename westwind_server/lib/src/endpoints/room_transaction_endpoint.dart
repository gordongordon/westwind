import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/src/generated/roomTransaction.dart';


class RoomTransactionEndpoint extends Endpoint {

  Future<List<RoomTransaction>> list(Session session) async {
    return RoomTransaction.db.find(session);
  }

  Future<RoomTransaction> create(Session session, RoomTransaction rt) async {
    return RoomTransaction.db.insertRow(session, rt );
  }

  Future<RoomTransaction?> retrieve(Session session, int id ) async {
     return await RoomTransaction.db.findFirstRow(session, 
      where : (item) => item.id.equals( id),
    );
  }

  Future<bool> delete(Session session, int id) async {

    final rt = await RoomTransaction.db.findFirstRow(session, 
      where : (item) => item.id.equals( id),
    );


    if (rt == null) {
      return false;
    }

    final result = await RoomTransaction.db.deleteRow(session,  rt );

    if (result == id) {
      return true;
    }

    return false;
  }


}


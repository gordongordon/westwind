
import 'package:westwind_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/src/generated/rateReason.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class RateTableEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.
  Future<bool> createRateTable(Session session,
      {required RateTable rateTable}) async {
    // RateTable.dateCreate = DateTime.now();

    await RateTable.db.insertRow(session, rateTable);
    return true;
  }

  Future<double?> findRate(Session session,
      {required RateType rateType, required RateReason rateReason}) async {

    final item = await RateTable.db.findFirstRow(session,
        where: (t) =>
            (t.rateType.equals(rateType) & t.rateReason.equals(rateReason)));
    
    if ( item == null ) {
        return null;
     //   MyException( message: "ServerPod : Rate can't be found base on type $rateType & reason $rateReason ! ", errorType: ErrorType.NotFound);
    }

    return item.rate;

  }

  Future<double> getSingleRate( Session session, {required RateType type }) async {

    final result = await RateTable.db.findFirstRow(session, 
          where:  (r) => (r.rateType.equals( type ) & r.rateReason.equals( RateReason.single )),);

     if ( result == null ) {
         throw MyException(message: "ServerPod : Rate can't be found base on single and $type", errorType: ErrorType.NotFound );
     }
    
     return result.rate;
     
  }
  Future<bool> updateRateTable(Session session,
      {required RateTable rateTable}) async {
    // RateTable.dateUpdate = DateTime.now();
    await RateTable.db.updateRow(session, rateTable);
    return true;
  }

  Future<RateTable?> findRateTable(Session session, {required int id}) async {
    return await RateTable.db.findById(
      session,
      id,
    );
  }

  Future<List<RateTable>> findRateTableById(Session session,
      {required int id}) async {
    return await RateTable.db.find(
      session,
      where: (rateTable) => rateTable.id.equals(id),
    );
  }

  Future<List<RateTable>> getAllRateTables(Session session) async {
    return await RateTable.db.find(
      session,
      orderBy: (t) => t.id,
    );
  }
}

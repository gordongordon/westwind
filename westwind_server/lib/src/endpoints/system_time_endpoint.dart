import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/src/generated/protocol.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class SystemTimeEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.
  Future<SystemTime?> retrieve(Session session) async {
    return await SystemTime.db.findFirstRow(session);
  }

  Future<SystemTime?> extendByDay(Session session, int days) async {
    final time = await retrieve(session);

    if (time != null) {
      int daysToAdd = days;  // calculate the correct number of days to add here;
          time.lastAuditDate.add(Duration(days: daysToAdd));
      return SystemTime.db.updateRow(session, time);
    }

    return null;
  }

  Future<DateTime> getServerTime(Session session) async {
    return DateTime.now().toUtc(); // Return the server time in UTC
  }
}

import 'package:westwind_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class GuestEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.
  Future<List<Guest>> list( Session session) async {
    return Guest.db.find(session);
  }
 

  Future<Guest?> retrieve( Session session, int id) async {
    return Guest.db.findById(session, id);
  }


  Future<bool> createGuest(Session session, {required Guest guest}) async {
    guest.dateCreate = DateTime.now();

    await Guest.db.insertRow(session, guest);
    return true;
  }

  Future<bool> updateGuest(Session session, {required Guest guest}) async {
    guest.dateUpdate = DateTime.now();
    await Guest.db.updateRow(session, guest);
    return true;
  }

  Future<Guest?> findGuest(Session session, {required int guestId}) async {
    return await Guest.db.findById(
      session,
      guestId,
    );
  }

  Future<List<Guest>> findGuestById(Session session,
      {required int guestId}) async {
    if (guestId == 0) {
      return await Guest.db
          .find(session, include: Guest.include(company: Company.include()));
    } else {
      return await Guest.db.find(session,
          where: (guest) => guest.id.equals(guestId),
          include: Guest.include(company: Company.include()),
          orderBy: (t) => t.id,
          orderDescending: true,
          );
    }
  }

  Future<List<Guest>> getAllGuests(Session session) async {
    return await Guest.db.find(
      session,
      orderBy: (t) => t.id,
                orderDescending: true,
    );
  }
}

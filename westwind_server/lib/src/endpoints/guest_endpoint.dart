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
  Future<List<Guest>> list(Session session) async {
    return Guest.db.find(
      session,
      orderBy: (t) => t.lastName,
      orderDescending: false,
    );
  }

  Future<Guest?> retrieve(Session session, int id) async {
    return Guest.db.findById(session, id);
  }

  Future<Guest> save(Session session, Guest guest) async {
    if (guest.id != null) {
      guest.dateUpdate = DateTime.now().toUtc();
      final existingGuest = await Guest.db.findById(session, guest.id!);
      if (existingGuest == null) {
        throw Exception('Guest not found id ${guest.id!}');
      }
      return await Guest.db.updateRow(session, guest);
    } else {
      guest.dateCreate = DateTime.now().toUtc();
      return Guest.db.insertRow(session, guest);
    }
  }

  Future<Guest?> retrieveGuestByPhone(Session session,
      {required String phone}) async {
    return await Guest.db.findFirstRow(
      session,
      where: (guest) => guest.phone.equals(phone),
    );
  }

  Future<List<Guest>> retrieveGuestByName(Session session,
      {required String name}) async {
    final String filter = '$name%';

    return await Guest.db.find(
      session,
      where: (guest) => guest.lastName.ilike(filter) | guest.firstName.ilike(filter) ,
      orderBy: (t) => t.lastName,
      orderDescending: false,
    );
  }

  Future<List<Guest>> retrieveGuestByLastName(Session session,
      {required String lastName}) async {
    final String filter = '$lastName%';

    return await Guest.db.find(
      session,
      where: (guest) => guest.lastName.ilike(filter) ,
      orderBy: (t) => t.lastName,
      orderDescending: false,
    );
  }

  Future<List<Guest>> retrieveGuestByFirstName(Session session,
      {required String firstName}) async {
    final String filter = '$firstName%';

    return await Guest.db.find(
      session,
      where: (guest) => guest.firstName.ilike(filter),
      orderBy: (t) => t.lastName,
      orderDescending: false,
    );
  }

  Future<Guest> createGuest(Session session, {required Guest guest}) async {
    guest.dateCreate = DateTime.now().toUtc();

    return await Guest.db.insertRow(session, guest);
    // return true;
  }

  Future<bool> updateGuest(Session session, {required Guest guest}) async {
    guest.dateUpdate = DateTime.now().toUtc();
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
      return await Guest.db.find(
        session,
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

  Future<bool> delete(Session session, int id) async {
    final guest = await Guest.db.findById(session, id);

    if (guest == null) {
      return false;
    }

    final result = await Guest.db.deleteRow(session, guest);

    if (result == id) {
      return true;
    }

    return false;
  }
}

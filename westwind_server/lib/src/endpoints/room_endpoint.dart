import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/src/generated/protocol.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class RoomEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter.
  // `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,
  // and other serializable classes, exceptions and enums from your from your `protocol` directory.
  // The methods should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.
  Future<Room?> retrieve(Session session, int id) async {
    return await Room.db.findById(session, id);
  }

  Future<List<Room>> list(Session session) async {
    return await Room.db.find(
      session,
      orderByList: (t) => [
        Order(column: t.id, orderDescending: false),
      ],
    );
  }

  Future<Room?> toggleRoomStatus(Session session, int roomId) async {
    final result = await Room.db.findById(session, roomId);

    if (result != null) {
      switch (result.roomStatus) {
        case RoomStatus.CO:
          result.roomStatus = RoomStatus.M;
          break;

        case RoomStatus.M:
          result.roomStatus = RoomStatus.MM;
          break;

        case RoomStatus.MM:
          result.roomStatus = RoomStatus.CH;
          break;

        case RoomStatus.DDD:
          result.roomStatus = RoomStatus.DRT;
          break;

        case RoomStatus.DRT:
          result.roomStatus = RoomStatus.BLK;
          break;

        case RoomStatus.VCC:
          result.roomStatus = RoomStatus.M;
          break;
        case RoomStatus.CH:
          result.roomStatus = RoomStatus.DDD;
          break;

        case RoomStatus.BLK:
          result.roomStatus = RoomStatus.VCC;
          break;

      }
      return await Room.db.updateRow(session, result);
    }

    return null;
  }
}

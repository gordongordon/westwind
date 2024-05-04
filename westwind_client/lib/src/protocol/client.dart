/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:westwind_client/src/protocol/guest.dart' as _i3;
import 'package:westwind_client/src/protocol/rateTable.dart' as _i4;
import 'package:westwind_client/src/protocol/rateType.dart' as _i5;
import 'package:westwind_client/src/protocol/rateReason.dart' as _i6;
import 'package:westwind_client/src/protocol/reservation.dart' as _i7;
import 'package:westwind_client/src/protocol/roomGuest.dart' as _i8;
import 'package:serverpod_auth_client/module.dart' as _i9;
import 'protocol.dart' as _i10;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointGuest extends _i1.EndpointRef {
  EndpointGuest(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'guest';

  _i2.Future<List<_i3.Guest>> list() =>
      caller.callServerEndpoint<List<_i3.Guest>>(
        'guest',
        'list',
        {},
      );

  _i2.Future<_i3.Guest?> retrieve(int id) =>
      caller.callServerEndpoint<_i3.Guest?>(
        'guest',
        'retrieve',
        {'id': id},
      );

  _i2.Future<bool> createGuest({required _i3.Guest guest}) =>
      caller.callServerEndpoint<bool>(
        'guest',
        'createGuest',
        {'guest': guest},
      );

  _i2.Future<bool> updateGuest({required _i3.Guest guest}) =>
      caller.callServerEndpoint<bool>(
        'guest',
        'updateGuest',
        {'guest': guest},
      );

  _i2.Future<_i3.Guest?> findGuest({required int guestId}) =>
      caller.callServerEndpoint<_i3.Guest?>(
        'guest',
        'findGuest',
        {'guestId': guestId},
      );

  _i2.Future<List<_i3.Guest>> findGuestById({required int guestId}) =>
      caller.callServerEndpoint<List<_i3.Guest>>(
        'guest',
        'findGuestById',
        {'guestId': guestId},
      );

  _i2.Future<List<_i3.Guest>> getAllGuests() =>
      caller.callServerEndpoint<List<_i3.Guest>>(
        'guest',
        'getAllGuests',
        {},
      );
}

/// {@category Endpoint}
class EndpointRateTable extends _i1.EndpointRef {
  EndpointRateTable(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rateTable';

  _i2.Future<bool> createRateTable({required _i4.RateTable rateTable}) =>
      caller.callServerEndpoint<bool>(
        'rateTable',
        'createRateTable',
        {'rateTable': rateTable},
      );

  _i2.Future<double> findRate({
    required _i5.RateType rateType,
    required _i6.RateReason rateReason,
  }) =>
      caller.callServerEndpoint<double>(
        'rateTable',
        'findRate',
        {
          'rateType': rateType,
          'rateReason': rateReason,
        },
      );

  _i2.Future<bool> updateRateTable({required _i4.RateTable rateTable}) =>
      caller.callServerEndpoint<bool>(
        'rateTable',
        'updateRateTable',
        {'rateTable': rateTable},
      );

  _i2.Future<_i4.RateTable?> findRateTable({required int id}) =>
      caller.callServerEndpoint<_i4.RateTable?>(
        'rateTable',
        'findRateTable',
        {'id': id},
      );

  _i2.Future<List<_i4.RateTable>> findRateTableById({required int id}) =>
      caller.callServerEndpoint<List<_i4.RateTable>>(
        'rateTable',
        'findRateTableById',
        {'id': id},
      );

  _i2.Future<List<_i4.RateTable>> getAllRateTables() =>
      caller.callServerEndpoint<List<_i4.RateTable>>(
        'rateTable',
        'getAllRateTables',
        {},
      );
}

/// {@category Endpoint}
class EndpointReservation extends _i1.EndpointRef {
  EndpointReservation(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reservation';

  _i2.Future<_i7.Reservation> createReservation(_i7.Reservation res) =>
      caller.callServerEndpoint<_i7.Reservation>(
        'reservation',
        'createReservation',
        {'res': res},
      );

  _i2.Future<_i7.Reservation?> findReservation({required int id}) =>
      caller.callServerEndpoint<_i7.Reservation?>(
        'reservation',
        'findReservation',
        {'id': id},
      );

  _i2.Future<_i7.Reservation> cancelReservation({required int id}) =>
      caller.callServerEndpoint<_i7.Reservation>(
        'reservation',
        'cancelReservation',
        {'id': id},
      );

  _i2.Future<bool> updateReservation({required _i7.Reservation reservation}) =>
      caller.callServerEndpoint<bool>(
        'reservation',
        'updateReservation',
        {'reservation': reservation},
      );

  _i2.Future<List<_i7.Reservation>> findReservationById({required int id}) =>
      caller.callServerEndpoint<List<_i7.Reservation>>(
        'reservation',
        'findReservationById',
        {'id': id},
      );

  _i2.Future<List<_i7.Reservation>> getAllReservations() =>
      caller.callServerEndpoint<List<_i7.Reservation>>(
        'reservation',
        'getAllReservations',
        {},
      );

  _i2.Future<List<_i7.Reservation>> getNullCheckInReservations() =>
      caller.callServerEndpoint<List<_i7.Reservation>>(
        'reservation',
        'getNullCheckInReservations',
        {},
      );

  _i2.Future<List<_i7.Reservation>> getAllReservationsByDay(
          DateTime datetime) =>
      caller.callServerEndpoint<List<_i7.Reservation>>(
        'reservation',
        'getAllReservationsByDay',
        {'datetime': datetime},
      );

  _i2.Future<List<_i7.Reservation>> getTodayReservations() =>
      caller.callServerEndpoint<List<_i7.Reservation>>(
        'reservation',
        'getTodayReservations',
        {},
      );

  _i2.Future<bool> checkInReservation({required int reservationId}) =>
      caller.callServerEndpoint<bool>(
        'reservation',
        'checkInReservation',
        {'reservationId': reservationId},
      );
}

/// {@category Endpoint}
class EndpointRoomGuest extends _i1.EndpointRef {
  EndpointRoomGuest(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'roomGuest';

  _i2.Future<_i8.RoomGuest> createRoomGuest(_i8.RoomGuest res) =>
      caller.callServerEndpoint<_i8.RoomGuest>(
        'roomGuest',
        'createRoomGuest',
        {'res': res},
      );

  _i2.Future<_i8.RoomGuest?> findRoomGuest({required int roomGuestId}) =>
      caller.callServerEndpoint<_i8.RoomGuest?>(
        'roomGuest',
        'findRoomGuest',
        {'roomGuestId': roomGuestId},
      );

  _i2.Future<bool> updateRoomGuest({required _i8.RoomGuest roomGuest}) =>
      caller.callServerEndpoint<bool>(
        'roomGuest',
        'updateRoomGuest',
        {'roomGuest': roomGuest},
      );

  _i2.Future<List<_i8.RoomGuest>> findRoomGuestByRoomId({required int id}) =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'findRoomGuestByRoomId',
        {'id': id},
      );

  _i2.Future<List<_i8.RoomGuest>> getAllRoomGuest() =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'getAllRoomGuest',
        {},
      );

  _i2.Future<List<_i8.RoomGuest>> getAllRoomGuestByDay(DateTime datetime) =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'getAllRoomGuestByDay',
        {'datetime': datetime},
      );

  _i2.Future<List<_i8.RoomGuest>> getTodayRoomGuest() =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'getTodayRoomGuest',
        {},
      );

  _i2.Future<int> updateRateReasonSingle(
          {required _i6.RateReason rateReason}) =>
      caller.callServerEndpoint<int>(
        'roomGuest',
        'updateRateReasonSingle',
        {'rateReason': rateReason},
      );

  _i2.Future<int> updateRateReasonShare({required _i6.RateReason rateReason}) =>
      caller.callServerEndpoint<int>(
        'roomGuest',
        'updateRateReasonShare',
        {'rateReason': rateReason},
      );

  _i2.Future<int> updateRateReasonDoulbe(
          {required _i6.RateReason rateReason}) =>
      caller.callServerEndpoint<int>(
        'roomGuest',
        'updateRateReasonDoulbe',
        {'rateReason': rateReason},
      );

  _i2.Future<int> updateRateReasonGoHome(
          {required _i6.RateReason rateReason}) =>
      caller.callServerEndpoint<int>(
        'roomGuest',
        'updateRateReasonGoHome',
        {'rateReason': rateReason},
      );

  _i2.Future<int> updateRateReasonOther({required _i6.RateReason rateReason}) =>
      caller.callServerEndpoint<int>(
        'roomGuest',
        'updateRateReasonOther',
        {'rateReason': rateReason},
      );

  _i2.Future<List<_i8.RoomGuest>> findRoommates(
          {required _i8.RoomGuest roomGuest}) =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'findRoommates',
        {'roomGuest': roomGuest},
      );

  _i2.Future<double> getRate({required _i8.RoomGuest roomGuest}) =>
      caller.callServerEndpoint<double>(
        'roomGuest',
        'getRate',
        {'roomGuest': roomGuest},
      );

  _i2.Future<_i8.RoomGuest?> findById({required int id}) =>
      caller.callServerEndpoint<_i8.RoomGuest?>(
        'roomGuest',
        'findById',
        {'id': id},
      );

  _i2.Future<List<int>> delete({required int id}) =>
      caller.callServerEndpoint<List<int>>(
        'roomGuest',
        'delete',
        {'id': id},
      );

  _i2.Future<int> checkOut({
    required _i8.RoomGuest roommate,
    required _i8.RoomGuest roomGuest,
  }) =>
      caller.callServerEndpoint<int>(
        'roomGuest',
        'checkOut',
        {
          'roommate': roommate,
          'roomGuest': roomGuest,
        },
      );

  _i2.Future<_i8.RoomGuest> updateGuestRate({
    required int id,
    required double rate,
  }) =>
      caller.callServerEndpoint<_i8.RoomGuest>(
        'roomGuest',
        'updateGuestRate',
        {
          'id': id,
          'rate': rate,
        },
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i9.Caller(client);
  }

  late final _i9.Caller auth;
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i10.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    example = EndpointExample(this);
    guest = EndpointGuest(this);
    rateTable = EndpointRateTable(this);
    reservation = EndpointReservation(this);
    roomGuest = EndpointRoomGuest(this);
    modules = _Modules(this);
  }

  late final EndpointExample example;

  late final EndpointGuest guest;

  late final EndpointRateTable rateTable;

  late final EndpointReservation reservation;

  late final EndpointRoomGuest roomGuest;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'guest': guest,
        'rateTable': rateTable,
        'reservation': reservation,
        'roomGuest': roomGuest,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

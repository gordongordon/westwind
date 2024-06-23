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
import 'package:westwind_client/src/protocol/roomTransaction.dart' as _i9;
import 'package:serverpod_auth_client/module.dart' as _i10;
import 'protocol.dart' as _i11;

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

  _i2.Future<_i3.Guest> save(_i3.Guest guest) =>
      caller.callServerEndpoint<_i3.Guest>(
        'guest',
        'save',
        {'guest': guest},
      );

  _i2.Future<_i3.Guest?> retrieveGuestByPhone({required String phone}) =>
      caller.callServerEndpoint<_i3.Guest?>(
        'guest',
        'retrieveGuestByPhone',
        {'phone': phone},
      );

  _i2.Future<_i3.Guest> createGuest({required _i3.Guest guest}) =>
      caller.callServerEndpoint<_i3.Guest>(
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

  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'guest',
        'delete',
        {'id': id},
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

  _i2.Future<double?> findRate({
    required _i5.RateType rateType,
    required _i6.RateReason rateReason,
  }) =>
      caller.callServerEndpoint<double?>(
        'rateTable',
        'findRate',
        {
          'rateType': rateType,
          'rateReason': rateReason,
        },
      );

  _i2.Future<double> getSingleRate({required _i5.RateType type}) =>
      caller.callServerEndpoint<double>(
        'rateTable',
        'getSingleRate',
        {'type': type},
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

  _i2.Future<_i7.Reservation> save(_i7.Reservation reservation) =>
      caller.callServerEndpoint<_i7.Reservation>(
        'reservation',
        'save',
        {'reservation': reservation},
      );

  _i2.Future<_i7.Reservation> createReservation(_i7.Reservation res) =>
      caller.callServerEndpoint<_i7.Reservation>(
        'reservation',
        'createReservation',
        {'res': res},
      );

  _i2.Future<_i7.Reservation?> retrieve({required int id}) =>
      caller.callServerEndpoint<_i7.Reservation?>(
        'reservation',
        'retrieve',
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

  _i2.Future<List<_i7.Reservation>> list() =>
      caller.callServerEndpoint<List<_i7.Reservation>>(
        'reservation',
        'list',
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

  _i2.Future<bool> checkIn({required int reservationId}) =>
      caller.callServerEndpoint<bool>(
        'reservation',
        'checkIn',
        {'reservationId': reservationId},
      );

  _i2.Future<bool> checkInReservation({required int reservationId}) =>
      caller.callServerEndpoint<bool>(
        'reservation',
        'checkInReservation',
        {'reservationId': reservationId},
      );

  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'reservation',
        'delete',
        {'id': id},
      );

  _i2.Future<bool> checkInReservationSecondVersion(
          {required int reservationId}) =>
      caller.callServerEndpoint<bool>(
        'reservation',
        'checkInReservationSecondVersion',
        {'reservationId': reservationId},
      );
}

/// {@category Endpoint}
class EndpointRoomGuest extends _i1.EndpointRef {
  EndpointRoomGuest(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'roomGuest';

  _i2.Future<_i8.RoomGuest> saveRoomGuest(_i8.RoomGuest res) =>
      caller.callServerEndpoint<_i8.RoomGuest>(
        'roomGuest',
        'saveRoomGuest',
        {'res': res},
      );

  _i2.Future<_i8.RoomGuest> insertGuestByReservation(
    _i8.RoomGuest checkInGuest,
    _i7.Reservation reservation,
  ) =>
      caller.callServerEndpoint<_i8.RoomGuest>(
        'roomGuest',
        'insertGuestByReservation',
        {
          'checkInGuest': checkInGuest,
          'reservation': reservation,
        },
      );

  _i2.Future<List<_i8.RoomGuest>> changeAllRateByRoomId(
    int id,
    double rate,
  ) =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'changeAllRateByRoomId',
        {
          'id': id,
          'rate': rate,
        },
      );

  _i2.Future<List<_i8.RoomGuest>> changeAllRateReasonByRoomId(
    int id,
    _i6.RateReason reason,
  ) =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'changeAllRateReasonByRoomId',
        {
          'id': id,
          'reason': reason,
        },
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

  _i2.Future<List<_i8.RoomGuest>> updateRoomGuests(
          {required List<_i8.RoomGuest> roomGuests}) =>
      caller.callServerEndpoint<List<_i8.RoomGuest>>(
        'roomGuest',
        'updateRoomGuests',
        {'roomGuests': roomGuests},
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

  _i2.Future<bool> deleteById(int id) => caller.callServerEndpoint<bool>(
        'roomGuest',
        'deleteById',
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

/// {@category Endpoint}
class EndpointRoomTransaction extends _i1.EndpointRef {
  EndpointRoomTransaction(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'roomTransaction';

  _i2.Future<bool> hasBeenRoomChargedToday(int guestId) =>
      caller.callServerEndpoint<bool>(
        'roomTransaction',
        'hasBeenRoomChargedToday',
        {'guestId': guestId},
      );

  _i2.Future<List<_i9.RoomTransaction>> list() =>
      caller.callServerEndpoint<List<_i9.RoomTransaction>>(
        'roomTransaction',
        'list',
        {},
      );

  _i2.Future<_i9.RoomTransaction> create(_i9.RoomTransaction rt) =>
      caller.callServerEndpoint<_i9.RoomTransaction>(
        'roomTransaction',
        'create',
        {'rt': rt},
      );

  _i2.Future<_i9.RoomTransaction?> retrieve(int id) =>
      caller.callServerEndpoint<_i9.RoomTransaction?>(
        'roomTransaction',
        'retrieve',
        {'id': id},
      );

  _i2.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'roomTransaction',
        'delete',
        {'id': id},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i10.Caller(client);
  }

  late final _i10.Caller auth;
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
          _i11.Protocol(),
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
    roomTransaction = EndpointRoomTransaction(this);
    modules = _Modules(this);
  }

  late final EndpointExample example;

  late final EndpointGuest guest;

  late final EndpointRateTable rateTable;

  late final EndpointReservation reservation;

  late final EndpointRoomGuest roomGuest;

  late final EndpointRoomTransaction roomTransaction;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'guest': guest,
        'rateTable': rateTable,
        'reservation': reservation,
        'roomGuest': roomGuest,
        'roomTransaction': roomTransaction,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

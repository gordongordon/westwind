/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/guest_endpoint.dart' as _i3;
import '../endpoints/rate_Table_endpoint.dart' as _i4;
import '../endpoints/reservation_endpoint.dart' as _i5;
import '../endpoints/room_endpoint.dart' as _i6;
import '../endpoints/room_guest_endpoint.dart' as _i7;
import '../endpoints/room_transaction_endpoint.dart' as _i8;
import '../endpoints/system_time_endpoint.dart' as _i9;
import 'package:westwind_server/src/generated/guest.dart' as _i10;
import 'package:westwind_server/src/generated/rateTable.dart' as _i11;
import 'package:westwind_server/src/generated/rateType.dart' as _i12;
import 'package:westwind_server/src/generated/rateReason.dart' as _i13;
import 'package:westwind_server/src/generated/reservation.dart' as _i14;
import 'package:westwind_server/src/generated/roomGuest.dart' as _i15;
import 'package:westwind_server/src/generated/roomTransaction.dart' as _i16;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i17;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'example': _i2.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'guest': _i3.GuestEndpoint()
        ..initialize(
          server,
          'guest',
          null,
        ),
      'rateTable': _i4.RateTableEndpoint()
        ..initialize(
          server,
          'rateTable',
          null,
        ),
      'reservation': _i5.ReservationEndpoint()
        ..initialize(
          server,
          'reservation',
          null,
        ),
      'room': _i6.RoomEndpoint()
        ..initialize(
          server,
          'room',
          null,
        ),
      'roomGuest': _i7.RoomGuestEndpoint()
        ..initialize(
          server,
          'roomGuest',
          null,
        ),
      'roomTransaction': _i8.RoomTransactionEndpoint()
        ..initialize(
          server,
          'roomTransaction',
          null,
        ),
      'systemTime': _i9.SystemTimeEndpoint()
        ..initialize(
          server,
          'systemTime',
          null,
        ),
    };
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i2.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['guest'] = _i1.EndpointConnector(
      name: 'guest',
      endpoint: endpoints['guest']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).list(session),
        ),
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).retrieve(
            session,
            params['id'],
          ),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'guest': _i1.ParameterDescription(
              name: 'guest',
              type: _i1.getType<_i10.Guest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).save(
            session,
            params['guest'],
          ),
        ),
        'retrieveGuestByPhone': _i1.MethodConnector(
          name: 'retrieveGuestByPhone',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).retrieveGuestByPhone(
            session,
            phone: params['phone'],
          ),
        ),
        'createGuest': _i1.MethodConnector(
          name: 'createGuest',
          params: {
            'guest': _i1.ParameterDescription(
              name: 'guest',
              type: _i1.getType<_i10.Guest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).createGuest(
            session,
            guest: params['guest'],
          ),
        ),
        'updateGuest': _i1.MethodConnector(
          name: 'updateGuest',
          params: {
            'guest': _i1.ParameterDescription(
              name: 'guest',
              type: _i1.getType<_i10.Guest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).updateGuest(
            session,
            guest: params['guest'],
          ),
        ),
        'findGuest': _i1.MethodConnector(
          name: 'findGuest',
          params: {
            'guestId': _i1.ParameterDescription(
              name: 'guestId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).findGuest(
            session,
            guestId: params['guestId'],
          ),
        ),
        'findGuestById': _i1.MethodConnector(
          name: 'findGuestById',
          params: {
            'guestId': _i1.ParameterDescription(
              name: 'guestId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).findGuestById(
            session,
            guestId: params['guestId'],
          ),
        ),
        'getAllGuests': _i1.MethodConnector(
          name: 'getAllGuests',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).getAllGuests(session),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['guest'] as _i3.GuestEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['rateTable'] = _i1.EndpointConnector(
      name: 'rateTable',
      endpoint: endpoints['rateTable']!,
      methodConnectors: {
        'createRateTable': _i1.MethodConnector(
          name: 'createRateTable',
          params: {
            'rateTable': _i1.ParameterDescription(
              name: 'rateTable',
              type: _i1.getType<_i11.RateTable>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint).createRateTable(
            session,
            rateTable: params['rateTable'],
          ),
        ),
        'findRate': _i1.MethodConnector(
          name: 'findRate',
          params: {
            'rateType': _i1.ParameterDescription(
              name: 'rateType',
              type: _i1.getType<_i12.RateType>(),
              nullable: false,
            ),
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint).findRate(
            session,
            rateType: params['rateType'],
            rateReason: params['rateReason'],
          ),
        ),
        'getSingleRate': _i1.MethodConnector(
          name: 'getSingleRate',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i12.RateType>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint).getSingleRate(
            session,
            type: params['type'],
          ),
        ),
        'updateRateTable': _i1.MethodConnector(
          name: 'updateRateTable',
          params: {
            'rateTable': _i1.ParameterDescription(
              name: 'rateTable',
              type: _i1.getType<_i11.RateTable>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint).updateRateTable(
            session,
            rateTable: params['rateTable'],
          ),
        ),
        'findRateTable': _i1.MethodConnector(
          name: 'findRateTable',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint).findRateTable(
            session,
            id: params['id'],
          ),
        ),
        'findRateTableById': _i1.MethodConnector(
          name: 'findRateTableById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint)
                  .findRateTableById(
            session,
            id: params['id'],
          ),
        ),
        'getAllRateTables': _i1.MethodConnector(
          name: 'getAllRateTables',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['rateTable'] as _i4.RateTableEndpoint)
                  .getAllRateTables(session),
        ),
      },
    );
    connectors['reservation'] = _i1.EndpointConnector(
      name: 'reservation',
      endpoint: endpoints['reservation']!,
      methodConnectors: {
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'reservation': _i1.ParameterDescription(
              name: 'reservation',
              type: _i1.getType<_i14.Reservation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint).save(
            session,
            params['reservation'],
          ),
        ),
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint).retrieve(
            session,
            id: params['id'],
          ),
        ),
        'cancelReservation': _i1.MethodConnector(
          name: 'cancelReservation',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .cancelReservation(
            session,
            id: params['id'],
          ),
        ),
        'updateReservation': _i1.MethodConnector(
          name: 'updateReservation',
          params: {
            'reservation': _i1.ParameterDescription(
              name: 'reservation',
              type: _i1.getType<_i14.Reservation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .updateReservation(
            session,
            reservation: params['reservation'],
          ),
        ),
        'findReservationById': _i1.MethodConnector(
          name: 'findReservationById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .findReservationById(
            session,
            id: params['id'],
          ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .list(session),
        ),
        'listButCanceled': _i1.MethodConnector(
          name: 'listButCanceled',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .listButCanceled(session),
        ),
        'listButCanceledAndCheckIn': _i1.MethodConnector(
          name: 'listButCanceledAndCheckIn',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .listButCanceledAndCheckIn(session),
        ),
        'checkIn': _i1.MethodConnector(
          name: 'checkIn',
          params: {
            'reservationId': _i1.ParameterDescription(
              name: 'reservationId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint).checkIn(
            session,
            reservationId: params['reservationId'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['room'] = _i1.EndpointConnector(
      name: 'room',
      endpoint: endpoints['room']!,
      methodConnectors: {
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['room'] as _i6.RoomEndpoint).retrieve(
            session,
            params['id'],
          ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['room'] as _i6.RoomEndpoint).list(session),
        ),
      },
    );
    connectors['roomGuest'] = _i1.EndpointConnector(
      name: 'roomGuest',
      endpoint: endpoints['roomGuest']!,
      methodConnectors: {
        'saveRoomGuest': _i1.MethodConnector(
          name: 'saveRoomGuest',
          params: {
            'res': _i1.ParameterDescription(
              name: 'res',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).saveRoomGuest(
            session,
            params['res'],
          ),
        ),
        'insertGuestByReservation': _i1.MethodConnector(
          name: 'insertGuestByReservation',
          params: {
            'checkInGuest': _i1.ParameterDescription(
              name: 'checkInGuest',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            ),
            'reservation': _i1.ParameterDescription(
              name: 'reservation',
              type: _i1.getType<_i14.Reservation>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .insertGuestByReservation(
            session,
            params['checkInGuest'],
            params['reservation'],
          ),
        ),
        'changeAllRateByRoomId': _i1.MethodConnector(
          name: 'changeAllRateByRoomId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rate': _i1.ParameterDescription(
              name: 'rate',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .changeAllRateByRoomId(
            session,
            params['id'],
            params['rate'],
          ),
        ),
        'changeAllRateReasonByRoomId': _i1.MethodConnector(
          name: 'changeAllRateReasonByRoomId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .changeAllRateReasonByRoomId(
            session,
            params['id'],
            params['reason'],
          ),
        ),
        'findRoomGuest': _i1.MethodConnector(
          name: 'findRoomGuest',
          params: {
            'roomGuestId': _i1.ParameterDescription(
              name: 'roomGuestId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).findRoomGuest(
            session,
            roomGuestId: params['roomGuestId'],
          ),
        ),
        'updateRoomGuest': _i1.MethodConnector(
          name: 'updateRoomGuest',
          params: {
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).updateRoomGuest(
            session,
            roomGuest: params['roomGuest'],
          ),
        ),
        'updateRoomGuests': _i1.MethodConnector(
          name: 'updateRoomGuests',
          params: {
            'roomGuests': _i1.ParameterDescription(
              name: 'roomGuests',
              type: _i1.getType<List<_i15.RoomGuest>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRoomGuests(
            session,
            roomGuests: params['roomGuests'],
          ),
        ),
        'findRoomGuestByRoomId': _i1.MethodConnector(
          name: 'findRoomGuestByRoomId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .findRoomGuestByRoomId(
            session,
            id: params['id'],
          ),
        ),
        'retrieveRoommatesSameStayDayWithOutGoHomeById': _i1.MethodConnector(
          name: 'retrieveRoommatesSameStayDayWithOutGoHomeById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .retrieveRoommatesSameStayDayWithOutGoHomeById(
            session,
            id: params['id'],
          ),
        ),
        'updateRateSameStayDayByReasonAndId': _i1.MethodConnector(
          name: 'updateRateSameStayDayByReasonAndId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            ),
            'rate': _i1.ParameterDescription(
              name: 'rate',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRateSameStayDayByReasonAndId(
            session,
            params['id'],
            params['reason'],
            params['rate'],
          ),
        ),
        'retrieveRoommatesSameStayDayById': _i1.MethodConnector(
          name: 'retrieveRoommatesSameStayDayById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .retrieveRoommatesSameStayDayById(
            session,
            id: params['id'],
          ),
        ),
        'getAllRoomGuest': _i1.MethodConnector(
          name: 'getAllRoomGuest',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .getAllRoomGuest(session),
        ),
        'getAllRoomGuestButCheckOut': _i1.MethodConnector(
          name: 'getAllRoomGuestButCheckOut',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .getAllRoomGuestButCheckOut(session),
        ),
        'getAllRoomGuestByDay': _i1.MethodConnector(
          name: 'getAllRoomGuestByDay',
          params: {
            'datetime': _i1.ParameterDescription(
              name: 'datetime',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .getAllRoomGuestByDay(
            session,
            params['datetime'],
          ),
        ),
        'getTodayRoomGuest': _i1.MethodConnector(
          name: 'getTodayRoomGuest',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .getTodayRoomGuest(session),
        ),
        'updateRateReasonSingle': _i1.MethodConnector(
          name: 'updateRateReasonSingle',
          params: {
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRateReasonSingle(
            session,
            rateReason: params['rateReason'],
          ),
        ),
        'updateRateReasonShare': _i1.MethodConnector(
          name: 'updateRateReasonShare',
          params: {
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRateReasonShare(
            session,
            rateReason: params['rateReason'],
          ),
        ),
        'updateRateReasonDoulbe': _i1.MethodConnector(
          name: 'updateRateReasonDoulbe',
          params: {
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRateReasonDoulbe(
            session,
            rateReason: params['rateReason'],
          ),
        ),
        'updateRateReasonGoHome': _i1.MethodConnector(
          name: 'updateRateReasonGoHome',
          params: {
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRateReasonGoHome(
            session,
            rateReason: params['rateReason'],
          ),
        ),
        'updateRateReasonOther': _i1.MethodConnector(
          name: 'updateRateReasonOther',
          params: {
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i13.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint)
                  .updateRateReasonOther(
            session,
            rateReason: params['rateReason'],
          ),
        ),
        'findRoommates': _i1.MethodConnector(
          name: 'findRoommates',
          params: {
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).findRoommates(
            session,
            roomGuest: params['roomGuest'],
          ),
        ),
        'getRate': _i1.MethodConnector(
          name: 'getRate',
          params: {
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).getRate(
            session,
            roomGuest: params['roomGuest'],
          ),
        ),
        'findById': _i1.MethodConnector(
          name: 'findById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).findById(
            session,
            id: params['id'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).delete(
            session,
            id: params['id'],
          ),
        ),
        'deleteById': _i1.MethodConnector(
          name: 'deleteById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).deleteById(
            session,
            params['id'],
          ),
        ),
        'checkOut': _i1.MethodConnector(
          name: 'checkOut',
          params: {
            'roommate': _i1.ParameterDescription(
              name: 'roommate',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            ),
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i15.RoomGuest>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).checkOut(
            session,
            roommate: params['roommate'],
            roomGuest: params['roomGuest'],
          ),
        ),
        'updateGuestRate': _i1.MethodConnector(
          name: 'updateGuestRate',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rate': _i1.ParameterDescription(
              name: 'rate',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i7.RoomGuestEndpoint).updateGuestRate(
            session,
            id: params['id'],
            rate: params['rate'],
          ),
        ),
      },
    );
    connectors['roomTransaction'] = _i1.EndpointConnector(
      name: 'roomTransaction',
      endpoint: endpoints['roomTransaction']!,
      methodConnectors: {
        'hasBeenRoomChargedToday': _i1.MethodConnector(
          name: 'hasBeenRoomChargedToday',
          params: {
            'guestId': _i1.ParameterDescription(
              name: 'guestId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .hasBeenRoomChargedToday(
            session,
            params['guestId'],
          ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .list(session),
        ),
        'listWithItemTypeRoom': _i1.MethodConnector(
          name: 'listWithItemTypeRoom',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .listWithItemTypeRoom(session),
        ),
        'getTransactionsForRoomGuest': _i1.MethodConnector(
          name: 'getTransactionsForRoomGuest',
          params: {
            'roomGuestId': _i1.ParameterDescription(
              name: 'roomGuestId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .getTransactionsForRoomGuest(
            session,
            params['roomGuestId'],
          ),
        ),
        'saveRoomTransaciton': _i1.MethodConnector(
          name: 'saveRoomTransaciton',
          params: {
            'rt': _i1.ParameterDescription(
              name: 'rt',
              type: _i1.getType<_i16.RoomTransaction>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .saveRoomTransaciton(
            session,
            params['rt'],
          ),
        ),
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .retrieve(
            session,
            params['id'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomTransaction'] as _i8.RoomTransactionEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['systemTime'] = _i1.EndpointConnector(
      name: 'systemTime',
      endpoint: endpoints['systemTime']!,
      methodConnectors: {
        'retrieve': _i1.MethodConnector(
          name: 'retrieve',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['systemTime'] as _i9.SystemTimeEndpoint).retrieve(
            session,
            params['id'],
          ),
        ),
        'getServerTime': _i1.MethodConnector(
          name: 'getServerTime',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['systemTime'] as _i9.SystemTimeEndpoint)
                  .getServerTime(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i17.Endpoints()..initializeEndpoints(server);
  }
}

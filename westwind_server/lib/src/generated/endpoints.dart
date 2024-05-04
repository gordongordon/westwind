/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/guest_endpoint.dart' as _i3;
import '../endpoints/rate_Table_endpoint.dart' as _i4;
import '../endpoints/reservation_endpoint.dart' as _i5;
import '../endpoints/room_guest_endpoint.dart' as _i6;
import 'package:westwind_server/src/generated/guest.dart' as _i7;
import 'package:westwind_server/src/generated/rateTable.dart' as _i8;
import 'package:westwind_server/src/generated/rateType.dart' as _i9;
import 'package:westwind_server/src/generated/rateReason.dart' as _i10;
import 'package:westwind_server/src/generated/reservation.dart' as _i11;
import 'package:westwind_server/src/generated/roomGuest.dart' as _i12;
import 'package:serverpod_auth_server/module.dart' as _i13;

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
      'roomGuest': _i6.RoomGuestEndpoint()
        ..initialize(
          server,
          'roomGuest',
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
        'createGuest': _i1.MethodConnector(
          name: 'createGuest',
          params: {
            'guest': _i1.ParameterDescription(
              name: 'guest',
              type: _i1.getType<_i7.Guest>(),
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
              type: _i1.getType<_i7.Guest>(),
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
              type: _i1.getType<_i8.RateTable>(),
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
              type: _i1.getType<_i9.RateType>(),
              nullable: false,
            ),
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i10.RateReason>(),
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
        'updateRateTable': _i1.MethodConnector(
          name: 'updateRateTable',
          params: {
            'rateTable': _i1.ParameterDescription(
              name: 'rateTable',
              type: _i1.getType<_i8.RateTable>(),
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
        'createReservation': _i1.MethodConnector(
          name: 'createReservation',
          params: {
            'res': _i1.ParameterDescription(
              name: 'res',
              type: _i1.getType<_i11.Reservation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .createReservation(
            session,
            params['res'],
          ),
        ),
        'findReservation': _i1.MethodConnector(
          name: 'findReservation',
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
                  .findReservation(
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
              type: _i1.getType<_i11.Reservation>(),
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
        'getAllReservations': _i1.MethodConnector(
          name: 'getAllReservations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .getAllReservations(session),
        ),
        'getNullCheckInReservations': _i1.MethodConnector(
          name: 'getNullCheckInReservations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .getNullCheckInReservations(session),
        ),
        'getAllReservationsByDay': _i1.MethodConnector(
          name: 'getAllReservationsByDay',
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
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .getAllReservationsByDay(
            session,
            params['datetime'],
          ),
        ),
        'getTodayReservations': _i1.MethodConnector(
          name: 'getTodayReservations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .getTodayReservations(session),
        ),
        'checkInReservation': _i1.MethodConnector(
          name: 'checkInReservation',
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
              (endpoints['reservation'] as _i5.ReservationEndpoint)
                  .checkInReservation(
            session,
            reservationId: params['reservationId'],
          ),
        ),
      },
    );
    connectors['roomGuest'] = _i1.EndpointConnector(
      name: 'roomGuest',
      endpoint: endpoints['roomGuest']!,
      methodConnectors: {
        'createRoomGuest': _i1.MethodConnector(
          name: 'createRoomGuest',
          params: {
            'res': _i1.ParameterDescription(
              name: 'res',
              type: _i1.getType<_i12.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).createRoomGuest(
            session,
            params['res'],
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).findRoomGuest(
            session,
            roomGuestId: params['roomGuestId'],
          ),
        ),
        'updateRoomGuest': _i1.MethodConnector(
          name: 'updateRoomGuest',
          params: {
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i12.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).updateRoomGuest(
            session,
            roomGuest: params['roomGuest'],
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
                  .findRoomGuestByRoomId(
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
                  .getAllRoomGuest(session),
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
                  .getTodayRoomGuest(session),
        ),
        'updateRateReasonSingle': _i1.MethodConnector(
          name: 'updateRateReasonSingle',
          params: {
            'rateReason': _i1.ParameterDescription(
              name: 'rateReason',
              type: _i1.getType<_i10.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
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
              type: _i1.getType<_i10.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
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
              type: _i1.getType<_i10.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
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
              type: _i1.getType<_i10.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
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
              type: _i1.getType<_i10.RateReason>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint)
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
              type: _i1.getType<_i12.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).findRoommates(
            session,
            roomGuest: params['roomGuest'],
          ),
        ),
        'getRate': _i1.MethodConnector(
          name: 'getRate',
          params: {
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i12.RoomGuest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).getRate(
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).findById(
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).delete(
            session,
            id: params['id'],
          ),
        ),
        'checkOut': _i1.MethodConnector(
          name: 'checkOut',
          params: {
            'roommate': _i1.ParameterDescription(
              name: 'roommate',
              type: _i1.getType<_i12.RoomGuest>(),
              nullable: false,
            ),
            'roomGuest': _i1.ParameterDescription(
              name: 'roomGuest',
              type: _i1.getType<_i12.RoomGuest>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).checkOut(
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
              (endpoints['roomGuest'] as _i6.RoomGuestEndpoint).updateGuestRate(
            session,
            id: params['id'],
            rate: params['rate'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i13.Endpoints()..initializeEndpoints(server);
  }
}

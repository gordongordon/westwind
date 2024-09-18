/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class RoomGuest implements _i1.SerializableModel {
  RoomGuest._({
    this.id,
    required this.roomId,
    this.room,
    required this.stayDay,
    required this.guestId,
    this.guest,
    this.roomTransactions,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.reservationId,
    this.reservation,
    required this.roomStatus,
    required this.checkInDate,
    required this.checkOutDate,
    this.updateDate,
    required this.isCheckOut,
  });

  factory RoomGuest({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDay,
    required int guestId,
    _i2.Guest? guest,
    List<_i2.RoomTransaction>? roomTransactions,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i2.Reservation? reservation,
    required _i2.RoomStatus roomStatus,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    DateTime? updateDate,
    required bool isCheckOut,
  }) = _RoomGuestImpl;

  factory RoomGuest.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomGuest(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i2.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      stayDay: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stayDay']),
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      roomTransactions: (jsonSerialization['roomTransactions'] as List?)
          ?.map(
              (e) => _i2.RoomTransaction.fromJson((e as Map<String, dynamic>)))
          .toList(),
      rateType:
          _i2.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i2.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
      reservationId: jsonSerialization['reservationId'] as int,
      reservation: jsonSerialization['reservation'] == null
          ? null
          : _i2.Reservation.fromJson(
              (jsonSerialization['reservation'] as Map<String, dynamic>)),
      roomStatus:
          _i2.RoomStatus.fromJson((jsonSerialization['roomStatus'] as String)),
      checkInDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkInDate']),
      checkOutDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkOutDate']),
      updateDate: jsonSerialization['updateDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateDate']),
      isCheckOut: jsonSerialization['isCheckOut'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  _i2.Room? room;

  DateTime stayDay;

  int guestId;

  _i2.Guest? guest;

  List<_i2.RoomTransaction>? roomTransactions;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  int reservationId;

  _i2.Reservation? reservation;

  _i2.RoomStatus roomStatus;

  DateTime checkInDate;

  DateTime checkOutDate;

  DateTime? updateDate;

  bool isCheckOut;

  RoomGuest copyWith({
    int? id,
    int? roomId,
    _i2.Room? room,
    DateTime? stayDay,
    int? guestId,
    _i2.Guest? guest,
    List<_i2.RoomTransaction>? roomTransactions,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    int? reservationId,
    _i2.Reservation? reservation,
    _i2.RoomStatus? roomStatus,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    DateTime? updateDate,
    bool? isCheckOut,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'stayDay': stayDay.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      if (roomTransactions != null)
        'roomTransactions':
            roomTransactions?.toJson(valueToJson: (v) => v.toJson()),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'reservationId': reservationId,
      if (reservation != null) 'reservation': reservation?.toJson(),
      'roomStatus': roomStatus.toJson(),
      'checkInDate': checkInDate.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'isCheckOut': isCheckOut,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomGuestImpl extends RoomGuest {
  _RoomGuestImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDay,
    required int guestId,
    _i2.Guest? guest,
    List<_i2.RoomTransaction>? roomTransactions,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i2.Reservation? reservation,
    required _i2.RoomStatus roomStatus,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    DateTime? updateDate,
    required bool isCheckOut,
  }) : super._(
          id: id,
          roomId: roomId,
          room: room,
          stayDay: stayDay,
          guestId: guestId,
          guest: guest,
          roomTransactions: roomTransactions,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          reservationId: reservationId,
          reservation: reservation,
          roomStatus: roomStatus,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          updateDate: updateDate,
          isCheckOut: isCheckOut,
        );

  @override
  RoomGuest copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    DateTime? stayDay,
    int? guestId,
    Object? guest = _Undefined,
    Object? roomTransactions = _Undefined,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    int? reservationId,
    Object? reservation = _Undefined,
    _i2.RoomStatus? roomStatus,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    Object? updateDate = _Undefined,
    bool? isCheckOut,
  }) {
    return RoomGuest(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      stayDay: stayDay ?? this.stayDay,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomTransactions: roomTransactions is List<_i2.RoomTransaction>?
          ? roomTransactions
          : this.roomTransactions?.map((e0) => e0.copyWith()).toList(),
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      reservationId: reservationId ?? this.reservationId,
      reservation: reservation is _i2.Reservation?
          ? reservation
          : this.reservation?.copyWith(),
      roomStatus: roomStatus ?? this.roomStatus,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      isCheckOut: isCheckOut ?? this.isCheckOut,
    );
  }
}

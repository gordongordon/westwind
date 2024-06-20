/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class RoomGuest extends _i1.SerializableEntity {
  RoomGuest._({
    this.id,
    required this.roomId,
    this.room,
    required this.stayDate,
    required this.guestId,
    this.guest,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.reservationId,
    this.reservation,
    required this.roomStatus,
    required this.checkOutDate,
    this.updateDate,
  });

  factory RoomGuest({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i2.Reservation? reservation,
    required _i2.RoomStatus roomStatus,
    required DateTime checkOutDate,
    DateTime? updateDate,
  }) = _RoomGuestImpl;

  factory RoomGuest.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomGuest(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomId:
          serializationManager.deserialize<int>(jsonSerialization['roomId']),
      room: serializationManager
          .deserialize<_i2.Room?>(jsonSerialization['room']),
      stayDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['stayDate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      rateReason: serializationManager
          .deserialize<_i2.RateReason>(jsonSerialization['rateReason']),
      rate: serializationManager.deserialize<double>(jsonSerialization['rate']),
      reservationId: serializationManager
          .deserialize<int>(jsonSerialization['reservationId']),
      reservation: serializationManager
          .deserialize<_i2.Reservation?>(jsonSerialization['reservation']),
      roomStatus: serializationManager
          .deserialize<_i2.RoomStatus>(jsonSerialization['roomStatus']),
      checkOutDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['checkOutDate']),
      updateDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['updateDate']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  _i2.Room? room;

  DateTime stayDate;

  int guestId;

  _i2.Guest? guest;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  int reservationId;

  _i2.Reservation? reservation;

  _i2.RoomStatus roomStatus;

  DateTime checkOutDate;

  DateTime? updateDate;

  RoomGuest copyWith({
    int? id,
    int? roomId,
    _i2.Room? room,
    DateTime? stayDate,
    int? guestId,
    _i2.Guest? guest,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    int? reservationId,
    _i2.Reservation? reservation,
    _i2.RoomStatus? roomStatus,
    DateTime? checkOutDate,
    DateTime? updateDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'stayDate': stayDate.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'reservationId': reservationId,
      if (reservation != null) 'reservation': reservation?.toJson(),
      'roomStatus': roomStatus.toJson(),
      'checkOutDate': checkOutDate.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
    };
  }
}

class _Undefined {}

class _RoomGuestImpl extends RoomGuest {
  _RoomGuestImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stayDate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required int reservationId,
    _i2.Reservation? reservation,
    required _i2.RoomStatus roomStatus,
    required DateTime checkOutDate,
    DateTime? updateDate,
  }) : super._(
          id: id,
          roomId: roomId,
          room: room,
          stayDate: stayDate,
          guestId: guestId,
          guest: guest,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          reservationId: reservationId,
          reservation: reservation,
          roomStatus: roomStatus,
          checkOutDate: checkOutDate,
          updateDate: updateDate,
        );

  @override
  RoomGuest copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    DateTime? stayDate,
    int? guestId,
    Object? guest = _Undefined,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    int? reservationId,
    Object? reservation = _Undefined,
    _i2.RoomStatus? roomStatus,
    DateTime? checkOutDate,
    Object? updateDate = _Undefined,
  }) {
    return RoomGuest(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      stayDate: stayDate ?? this.stayDate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      reservationId: reservationId ?? this.reservationId,
      reservation: reservation is _i2.Reservation?
          ? reservation
          : this.reservation?.copyWith(),
      roomStatus: roomStatus ?? this.roomStatus,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
    );
  }
}

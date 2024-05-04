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

abstract class GuestInOutDate extends _i1.SerializableEntity {
  GuestInOutDate._({
    this.id,
    required this.roomNumber,
    required this.dateCreate,
    this.dateUpdate,
    required this.guestId,
    this.guest,
    required this.inOutReason,
  });

  factory GuestInOutDate({
    int? id,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.InOutReason inOutReason,
  }) = _GuestInOutDateImpl;

  factory GuestInOutDate.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return GuestInOutDate(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      inOutReason: serializationManager
          .deserialize<_i2.InOutReason>(jsonSerialization['inOutReason']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.RoomNumber roomNumber;

  DateTime dateCreate;

  DateTime? dateUpdate;

  int guestId;

  _i2.Guest? guest;

  _i2.InOutReason inOutReason;

  GuestInOutDate copyWith({
    int? id,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? guestId,
    _i2.Guest? guest,
    _i2.InOutReason? inOutReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'inOutReason': inOutReason.toJson(),
    };
  }
}

class _Undefined {}

class _GuestInOutDateImpl extends GuestInOutDate {
  _GuestInOutDateImpl({
    int? id,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.InOutReason inOutReason,
  }) : super._(
          id: id,
          roomNumber: roomNumber,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          guestId: guestId,
          guest: guest,
          inOutReason: inOutReason,
        );

  @override
  GuestInOutDate copyWith({
    Object? id = _Undefined,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    _i2.InOutReason? inOutReason,
  }) {
    return GuestInOutDate(
      id: id is int? ? id : this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      inOutReason: inOutReason ?? this.inOutReason,
    );
  }
}

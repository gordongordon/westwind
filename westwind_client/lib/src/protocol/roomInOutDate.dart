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

abstract class RoomInOutDate extends _i1.SerializableEntity {
  RoomInOutDate._({
    this.id,
    this.checkInDate,
    this.checkOutDate,
    required this.guestId,
    this.guest,
    required this.roomNumber,
    required this.dateCreate,
  });

  factory RoomInOutDate({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
  }) = _RoomInOutDateImpl;

  factory RoomInOutDate.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomInOutDate(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      checkInDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['checkInDate']),
      checkOutDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['checkOutDate']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      roomNumber: serializationManager
          .deserialize<_i2.RoomNumber>(jsonSerialization['roomNumber']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime? checkInDate;

  DateTime? checkOutDate;

  int guestId;

  _i2.Guest? guest;

  _i2.RoomNumber roomNumber;

  DateTime dateCreate;

  RoomInOutDate copyWith({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guestId,
    _i2.Guest? guest,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (checkInDate != null) 'checkInDate': checkInDate?.toJson(),
      if (checkOutDate != null) 'checkOutDate': checkOutDate?.toJson(),
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'roomNumber': roomNumber.toJson(),
      'dateCreate': dateCreate.toJson(),
    };
  }
}

class _Undefined {}

class _RoomInOutDateImpl extends RoomInOutDate {
  _RoomInOutDateImpl({
    int? id,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    required int guestId,
    _i2.Guest? guest,
    required _i2.RoomNumber roomNumber,
    required DateTime dateCreate,
  }) : super._(
          id: id,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          guestId: guestId,
          guest: guest,
          roomNumber: roomNumber,
          dateCreate: dateCreate,
        );

  @override
  RoomInOutDate copyWith({
    Object? id = _Undefined,
    Object? checkInDate = _Undefined,
    Object? checkOutDate = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    _i2.RoomNumber? roomNumber,
    DateTime? dateCreate,
  }) {
    return RoomInOutDate(
      id: id is int? ? id : this.id,
      checkInDate: checkInDate is DateTime? ? checkInDate : this.checkInDate,
      checkOutDate:
          checkOutDate is DateTime? ? checkOutDate : this.checkOutDate,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomNumber: roomNumber ?? this.roomNumber,
      dateCreate: dateCreate ?? this.dateCreate,
    );
  }
}

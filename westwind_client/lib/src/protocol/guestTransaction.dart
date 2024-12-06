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
import 'room.dart' as _i2;
import 'rateType.dart' as _i3;
import 'rateReason.dart' as _i4;
import 'roomStatus.dart' as _i5;
import 'roomGuest.dart' as _i6;

abstract class GuestTransaction implements _i1.SerializableModel {
  GuestTransaction._({
    this.id,
    required this.roomId,
    this.room,
    required this.stateDate,
    required this.rateType,
    required this.rateReason,
    required this.rate,
    required this.roomStatus,
    this.updateDate,
    required this.roomGuestId,
    this.roomGuest,
  });

  factory GuestTransaction({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stateDate,
    required _i3.RateType rateType,
    required _i4.RateReason rateReason,
    required double rate,
    required _i5.RoomStatus roomStatus,
    DateTime? updateDate,
    required int roomGuestId,
    _i6.RoomGuest? roomGuest,
  }) = _GuestTransactionImpl;

  factory GuestTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuestTransaction(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i2.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      stateDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stateDate']),
      rateType:
          _i3.RateType.fromJson((jsonSerialization['rateType'] as String)),
      rateReason:
          _i4.RateReason.fromJson((jsonSerialization['rateReason'] as String)),
      rate: (jsonSerialization['rate'] as num).toDouble(),
      roomStatus:
          _i5.RoomStatus.fromJson((jsonSerialization['roomStatus'] as String)),
      updateDate: jsonSerialization['updateDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateDate']),
      roomGuestId: jsonSerialization['roomGuestId'] as int,
      roomGuest: jsonSerialization['roomGuest'] == null
          ? null
          : _i6.RoomGuest.fromJson(
              (jsonSerialization['roomGuest'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  _i2.Room? room;

  DateTime stateDate;

  _i3.RateType rateType;

  _i4.RateReason rateReason;

  double rate;

  _i5.RoomStatus roomStatus;

  DateTime? updateDate;

  int roomGuestId;

  _i6.RoomGuest? roomGuest;

  GuestTransaction copyWith({
    int? id,
    int? roomId,
    _i2.Room? room,
    DateTime? stateDate,
    _i3.RateType? rateType,
    _i4.RateReason? rateReason,
    double? rate,
    _i5.RoomStatus? roomStatus,
    DateTime? updateDate,
    int? roomGuestId,
    _i6.RoomGuest? roomGuest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'stateDate': stateDate.toJson(),
      'rateType': rateType.toJson(),
      'rateReason': rateReason.toJson(),
      'rate': rate,
      'roomStatus': roomStatus.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'roomGuestId': roomGuestId,
      if (roomGuest != null) 'roomGuest': roomGuest?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestTransactionImpl extends GuestTransaction {
  _GuestTransactionImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stateDate,
    required _i3.RateType rateType,
    required _i4.RateReason rateReason,
    required double rate,
    required _i5.RoomStatus roomStatus,
    DateTime? updateDate,
    required int roomGuestId,
    _i6.RoomGuest? roomGuest,
  }) : super._(
          id: id,
          roomId: roomId,
          room: room,
          stateDate: stateDate,
          rateType: rateType,
          rateReason: rateReason,
          rate: rate,
          roomStatus: roomStatus,
          updateDate: updateDate,
          roomGuestId: roomGuestId,
          roomGuest: roomGuest,
        );

  @override
  GuestTransaction copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    DateTime? stateDate,
    _i3.RateType? rateType,
    _i4.RateReason? rateReason,
    double? rate,
    _i5.RoomStatus? roomStatus,
    Object? updateDate = _Undefined,
    int? roomGuestId,
    Object? roomGuest = _Undefined,
  }) {
    return GuestTransaction(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      stateDate: stateDate ?? this.stateDate,
      rateType: rateType ?? this.rateType,
      rateReason: rateReason ?? this.rateReason,
      rate: rate ?? this.rate,
      roomStatus: roomStatus ?? this.roomStatus,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      roomGuestId: roomGuestId ?? this.roomGuestId,
      roomGuest:
          roomGuest is _i6.RoomGuest? ? roomGuest : this.roomGuest?.copyWith(),
    );
  }
}

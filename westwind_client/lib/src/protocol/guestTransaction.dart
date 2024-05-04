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

abstract class GuestTransaction extends _i1.SerializableEntity {
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
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required _i2.RoomStatus roomStatus,
    DateTime? updateDate,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
  }) = _GuestTransactionImpl;

  factory GuestTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return GuestTransaction(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      roomId:
          serializationManager.deserialize<int>(jsonSerialization['roomId']),
      room: serializationManager
          .deserialize<_i2.Room?>(jsonSerialization['room']),
      stateDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['stateDate']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      rateReason: serializationManager
          .deserialize<_i2.RateReason>(jsonSerialization['rateReason']),
      rate: serializationManager.deserialize<double>(jsonSerialization['rate']),
      roomStatus: serializationManager
          .deserialize<_i2.RoomStatus>(jsonSerialization['roomStatus']),
      updateDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['updateDate']),
      roomGuestId: serializationManager
          .deserialize<int>(jsonSerialization['roomGuestId']),
      roomGuest: serializationManager
          .deserialize<_i2.RoomGuest?>(jsonSerialization['roomGuest']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  _i2.Room? room;

  DateTime stateDate;

  _i2.RateType rateType;

  _i2.RateReason rateReason;

  double rate;

  _i2.RoomStatus roomStatus;

  DateTime? updateDate;

  int roomGuestId;

  _i2.RoomGuest? roomGuest;

  GuestTransaction copyWith({
    int? id,
    int? roomId,
    _i2.Room? room,
    DateTime? stateDate,
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    _i2.RoomStatus? roomStatus,
    DateTime? updateDate,
    int? roomGuestId,
    _i2.RoomGuest? roomGuest,
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
}

class _Undefined {}

class _GuestTransactionImpl extends GuestTransaction {
  _GuestTransactionImpl({
    int? id,
    required int roomId,
    _i2.Room? room,
    required DateTime stateDate,
    required _i2.RateType rateType,
    required _i2.RateReason rateReason,
    required double rate,
    required _i2.RoomStatus roomStatus,
    DateTime? updateDate,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
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
    _i2.RateType? rateType,
    _i2.RateReason? rateReason,
    double? rate,
    _i2.RoomStatus? roomStatus,
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
          roomGuest is _i2.RoomGuest? ? roomGuest : this.roomGuest?.copyWith(),
    );
  }
}

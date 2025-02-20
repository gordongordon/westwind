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
import 'guest.dart' as _i2;
import 'room.dart' as _i3;
import 'roomGuest.dart' as _i4;
import 'transactionType.dart' as _i5;
import 'itemType.dart' as _i6;

abstract class RoomTransaction implements _i1.SerializableModel {
  RoomTransaction._({
    this.id,
    required this.guestId,
    this.guest,
    required this.roomId,
    this.room,
    required this.roomGuestId,
    this.roomGuest,
    required this.stayDay,
    required this.transactionDay,
    required this.transactionType,
    this.approvedCode,
    this.updateDate,
    required this.amount,
    required this.tax1,
    required this.tax2,
    required this.total,
    required this.description,
    required this.itemType,
  });

  factory RoomTransaction({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i3.Room? room,
    required int roomGuestId,
    _i4.RoomGuest? roomGuest,
    required DateTime stayDay,
    required DateTime transactionDay,
    required _i5.TransactionType transactionType,
    String? approvedCode,
    DateTime? updateDate,
    required double amount,
    required double tax1,
    required double tax2,
    required double total,
    required String description,
    required _i6.ItemType itemType,
  }) = _RoomTransactionImpl;

  factory RoomTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomTransaction(
      id: jsonSerialization['id'] as int?,
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      roomId: jsonSerialization['roomId'] as int,
      room: jsonSerialization['room'] == null
          ? null
          : _i3.Room.fromJson(
              (jsonSerialization['room'] as Map<String, dynamic>)),
      roomGuestId: jsonSerialization['roomGuestId'] as int,
      roomGuest: jsonSerialization['roomGuest'] == null
          ? null
          : _i4.RoomGuest.fromJson(
              (jsonSerialization['roomGuest'] as Map<String, dynamic>)),
      stayDay: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stayDay']),
      transactionDay: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['transactionDay']),
      transactionType: _i5.TransactionType.fromJson(
          (jsonSerialization['transactionType'] as String)),
      approvedCode: jsonSerialization['approvedCode'] as String?,
      updateDate: jsonSerialization['updateDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateDate']),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      tax1: (jsonSerialization['tax1'] as num).toDouble(),
      tax2: (jsonSerialization['tax2'] as num).toDouble(),
      total: (jsonSerialization['total'] as num).toDouble(),
      description: jsonSerialization['description'] as String,
      itemType:
          _i6.ItemType.fromJson((jsonSerialization['itemType'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int guestId;

  _i2.Guest? guest;

  int roomId;

  _i3.Room? room;

  int roomGuestId;

  _i4.RoomGuest? roomGuest;

  DateTime stayDay;

  DateTime transactionDay;

  _i5.TransactionType transactionType;

  String? approvedCode;

  DateTime? updateDate;

  double amount;

  double tax1;

  double tax2;

  double total;

  String description;

  _i6.ItemType itemType;

  RoomTransaction copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    int? roomId,
    _i3.Room? room,
    int? roomGuestId,
    _i4.RoomGuest? roomGuest,
    DateTime? stayDay,
    DateTime? transactionDay,
    _i5.TransactionType? transactionType,
    String? approvedCode,
    DateTime? updateDate,
    double? amount,
    double? tax1,
    double? tax2,
    double? total,
    String? description,
    _i6.ItemType? itemType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'roomId': roomId,
      if (room != null) 'room': room?.toJson(),
      'roomGuestId': roomGuestId,
      if (roomGuest != null) 'roomGuest': roomGuest?.toJson(),
      'stayDay': stayDay.toJson(),
      'transactionDay': transactionDay.toJson(),
      'transactionType': transactionType.toJson(),
      if (approvedCode != null) 'approvedCode': approvedCode,
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'total': total,
      'description': description,
      'itemType': itemType.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomTransactionImpl extends RoomTransaction {
  _RoomTransactionImpl({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i3.Room? room,
    required int roomGuestId,
    _i4.RoomGuest? roomGuest,
    required DateTime stayDay,
    required DateTime transactionDay,
    required _i5.TransactionType transactionType,
    String? approvedCode,
    DateTime? updateDate,
    required double amount,
    required double tax1,
    required double tax2,
    required double total,
    required String description,
    required _i6.ItemType itemType,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          roomId: roomId,
          room: room,
          roomGuestId: roomGuestId,
          roomGuest: roomGuest,
          stayDay: stayDay,
          transactionDay: transactionDay,
          transactionType: transactionType,
          approvedCode: approvedCode,
          updateDate: updateDate,
          amount: amount,
          tax1: tax1,
          tax2: tax2,
          total: total,
          description: description,
          itemType: itemType,
        );

  @override
  RoomTransaction copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    int? roomId,
    Object? room = _Undefined,
    int? roomGuestId,
    Object? roomGuest = _Undefined,
    DateTime? stayDay,
    DateTime? transactionDay,
    _i5.TransactionType? transactionType,
    Object? approvedCode = _Undefined,
    Object? updateDate = _Undefined,
    double? amount,
    double? tax1,
    double? tax2,
    double? total,
    String? description,
    _i6.ItemType? itemType,
  }) {
    return RoomTransaction(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomId: roomId ?? this.roomId,
      room: room is _i3.Room? ? room : this.room?.copyWith(),
      roomGuestId: roomGuestId ?? this.roomGuestId,
      roomGuest:
          roomGuest is _i4.RoomGuest? ? roomGuest : this.roomGuest?.copyWith(),
      stayDay: stayDay ?? this.stayDay,
      transactionDay: transactionDay ?? this.transactionDay,
      transactionType: transactionType ?? this.transactionType,
      approvedCode: approvedCode is String? ? approvedCode : this.approvedCode,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      amount: amount ?? this.amount,
      tax1: tax1 ?? this.tax1,
      tax2: tax2 ?? this.tax2,
      total: total ?? this.total,
      description: description ?? this.description,
      itemType: itemType ?? this.itemType,
    );
  }
}

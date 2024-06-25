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

abstract class RoomTransaction extends _i1.SerializableEntity {
  RoomTransaction._({
    this.id,
    required this.guestId,
    this.guest,
    required this.roomId,
    this.room,
    required this.roomGuestId,
    this.roomGuest,
    this.stayDay,
    required this.transactionDay,
    required this.transactionType,
    this.updateDate,
    required this.amount,
    required this.tax1,
    required this.tax2,
    required this.tax3,
    required this.total,
    required this.description,
    required this.itemType,
  });

  factory RoomTransaction({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i2.Room? room,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
    DateTime? stayDay,
    required DateTime transactionDay,
    required _i2.TransactionType transactionType,
    DateTime? updateDate,
    required double amount,
    required double tax1,
    required double tax2,
    required double tax3,
    required double total,
    required String description,
    required _i2.ItemType itemType,
  }) = _RoomTransactionImpl;

  factory RoomTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomTransaction(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      roomId:
          serializationManager.deserialize<int>(jsonSerialization['roomId']),
      room: serializationManager
          .deserialize<_i2.Room?>(jsonSerialization['room']),
      roomGuestId: serializationManager
          .deserialize<int>(jsonSerialization['roomGuestId']),
      roomGuest: serializationManager
          .deserialize<_i2.RoomGuest?>(jsonSerialization['roomGuest']),
      stayDay: serializationManager
          .deserialize<DateTime?>(jsonSerialization['stayDay']),
      transactionDay: serializationManager
          .deserialize<DateTime>(jsonSerialization['transactionDay']),
      transactionType: serializationManager.deserialize<_i2.TransactionType>(
          jsonSerialization['transactionType']),
      updateDate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['updateDate']),
      amount:
          serializationManager.deserialize<double>(jsonSerialization['amount']),
      tax1: serializationManager.deserialize<double>(jsonSerialization['tax1']),
      tax2: serializationManager.deserialize<double>(jsonSerialization['tax2']),
      tax3: serializationManager.deserialize<double>(jsonSerialization['tax3']),
      total:
          serializationManager.deserialize<double>(jsonSerialization['total']),
      description: serializationManager
          .deserialize<String>(jsonSerialization['description']),
      itemType: serializationManager
          .deserialize<_i2.ItemType>(jsonSerialization['itemType']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int guestId;

  _i2.Guest? guest;

  int roomId;

  _i2.Room? room;

  int roomGuestId;

  _i2.RoomGuest? roomGuest;

  DateTime? stayDay;

  DateTime transactionDay;

  _i2.TransactionType transactionType;

  DateTime? updateDate;

  double amount;

  double tax1;

  double tax2;

  double tax3;

  double total;

  String description;

  _i2.ItemType itemType;

  RoomTransaction copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    int? roomId,
    _i2.Room? room,
    int? roomGuestId,
    _i2.RoomGuest? roomGuest,
    DateTime? stayDay,
    DateTime? transactionDay,
    _i2.TransactionType? transactionType,
    DateTime? updateDate,
    double? amount,
    double? tax1,
    double? tax2,
    double? tax3,
    double? total,
    String? description,
    _i2.ItemType? itemType,
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
      if (stayDay != null) 'stayDay': stayDay?.toJson(),
      'transactionDay': transactionDay.toJson(),
      'transactionType': transactionType.toJson(),
      if (updateDate != null) 'updateDate': updateDate?.toJson(),
      'amount': amount,
      'tax1': tax1,
      'tax2': tax2,
      'tax3': tax3,
      'total': total,
      'description': description,
      'itemType': itemType.toJson(),
    };
  }
}

class _Undefined {}

class _RoomTransactionImpl extends RoomTransaction {
  _RoomTransactionImpl({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required int roomId,
    _i2.Room? room,
    required int roomGuestId,
    _i2.RoomGuest? roomGuest,
    DateTime? stayDay,
    required DateTime transactionDay,
    required _i2.TransactionType transactionType,
    DateTime? updateDate,
    required double amount,
    required double tax1,
    required double tax2,
    required double tax3,
    required double total,
    required String description,
    required _i2.ItemType itemType,
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
          updateDate: updateDate,
          amount: amount,
          tax1: tax1,
          tax2: tax2,
          tax3: tax3,
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
    Object? stayDay = _Undefined,
    DateTime? transactionDay,
    _i2.TransactionType? transactionType,
    Object? updateDate = _Undefined,
    double? amount,
    double? tax1,
    double? tax2,
    double? tax3,
    double? total,
    String? description,
    _i2.ItemType? itemType,
  }) {
    return RoomTransaction(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      roomId: roomId ?? this.roomId,
      room: room is _i2.Room? ? room : this.room?.copyWith(),
      roomGuestId: roomGuestId ?? this.roomGuestId,
      roomGuest:
          roomGuest is _i2.RoomGuest? ? roomGuest : this.roomGuest?.copyWith(),
      stayDay: stayDay is DateTime? ? stayDay : this.stayDay,
      transactionDay: transactionDay ?? this.transactionDay,
      transactionType: transactionType ?? this.transactionType,
      updateDate: updateDate is DateTime? ? updateDate : this.updateDate,
      amount: amount ?? this.amount,
      tax1: tax1 ?? this.tax1,
      tax2: tax2 ?? this.tax2,
      tax3: tax3 ?? this.tax3,
      total: total ?? this.total,
      description: description ?? this.description,
      itemType: itemType ?? this.itemType,
    );
  }
}

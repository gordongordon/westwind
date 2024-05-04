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

abstract class Payment extends _i1.SerializableEntity {
  Payment._({
    this.id,
    required this.guestId,
    this.guest,
    required this.dateCreate,
    required this.dateVoid,
    required this.paymentAmount,
    required this.paymentType,
    required this.roomChargeType,
    required this.userId,
  });

  factory Payment({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime dateCreate,
    required DateTime dateVoid,
    required double paymentAmount,
    required _i2.PaymentType paymentType,
    required _i2.RoomChargeType roomChargeType,
    required int userId,
  }) = _PaymentImpl;

  factory Payment.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Payment(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      guestId:
          serializationManager.deserialize<int>(jsonSerialization['guestId']),
      guest: serializationManager
          .deserialize<_i2.Guest?>(jsonSerialization['guest']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateVoid: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateVoid']),
      paymentAmount: serializationManager
          .deserialize<double>(jsonSerialization['paymentAmount']),
      paymentType: serializationManager
          .deserialize<_i2.PaymentType>(jsonSerialization['paymentType']),
      roomChargeType: serializationManager
          .deserialize<_i2.RoomChargeType>(jsonSerialization['roomChargeType']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int guestId;

  _i2.Guest? guest;

  DateTime dateCreate;

  DateTime dateVoid;

  double paymentAmount;

  _i2.PaymentType paymentType;

  _i2.RoomChargeType roomChargeType;

  int userId;

  Payment copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    DateTime? dateCreate,
    DateTime? dateVoid,
    double? paymentAmount,
    _i2.PaymentType? paymentType,
    _i2.RoomChargeType? roomChargeType,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'dateCreate': dateCreate.toJson(),
      'dateVoid': dateVoid.toJson(),
      'paymentAmount': paymentAmount,
      'paymentType': paymentType.toJson(),
      'roomChargeType': roomChargeType.toJson(),
      'userId': userId,
    };
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime dateCreate,
    required DateTime dateVoid,
    required double paymentAmount,
    required _i2.PaymentType paymentType,
    required _i2.RoomChargeType roomChargeType,
    required int userId,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          dateCreate: dateCreate,
          dateVoid: dateVoid,
          paymentAmount: paymentAmount,
          paymentType: paymentType,
          roomChargeType: roomChargeType,
          userId: userId,
        );

  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    DateTime? dateCreate,
    DateTime? dateVoid,
    double? paymentAmount,
    _i2.PaymentType? paymentType,
    _i2.RoomChargeType? roomChargeType,
    int? userId,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      dateCreate: dateCreate ?? this.dateCreate,
      dateVoid: dateVoid ?? this.dateVoid,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentType: paymentType ?? this.paymentType,
      roomChargeType: roomChargeType ?? this.roomChargeType,
      userId: userId ?? this.userId,
    );
  }
}

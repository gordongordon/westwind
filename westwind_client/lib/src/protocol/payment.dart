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
    required this.chargeDate,
    required this.dateVoid,
    required this.amount,
    required this.description,
    required this.paymentType,
    required this.userId,
  });

  factory Payment({
    int? id,
    required int guestId,
    _i2.Guest? guest,
    required DateTime chargeDate,
    required DateTime dateVoid,
    required double amount,
    required String description,
    required _i2.PaymentType paymentType,
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
      chargeDate: serializationManager
          .deserialize<DateTime>(jsonSerialization['chargeDate']),
      dateVoid: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateVoid']),
      amount:
          serializationManager.deserialize<double>(jsonSerialization['amount']),
      description: serializationManager
          .deserialize<String>(jsonSerialization['description']),
      paymentType: serializationManager
          .deserialize<_i2.PaymentType>(jsonSerialization['paymentType']),
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

  DateTime chargeDate;

  DateTime dateVoid;

  double amount;

  String description;

  _i2.PaymentType paymentType;

  int userId;

  Payment copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    DateTime? chargeDate,
    DateTime? dateVoid,
    double? amount,
    String? description,
    _i2.PaymentType? paymentType,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
      'chargeDate': chargeDate.toJson(),
      'dateVoid': dateVoid.toJson(),
      'amount': amount,
      'description': description,
      'paymentType': paymentType.toJson(),
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
    required DateTime chargeDate,
    required DateTime dateVoid,
    required double amount,
    required String description,
    required _i2.PaymentType paymentType,
    required int userId,
  }) : super._(
          id: id,
          guestId: guestId,
          guest: guest,
          chargeDate: chargeDate,
          dateVoid: dateVoid,
          amount: amount,
          description: description,
          paymentType: paymentType,
          userId: userId,
        );

  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? guestId,
    Object? guest = _Undefined,
    DateTime? chargeDate,
    DateTime? dateVoid,
    double? amount,
    String? description,
    _i2.PaymentType? paymentType,
    int? userId,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      guestId: guestId ?? this.guestId,
      guest: guest is _i2.Guest? ? guest : this.guest?.copyWith(),
      chargeDate: chargeDate ?? this.chargeDate,
      dateVoid: dateVoid ?? this.dateVoid,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      paymentType: paymentType ?? this.paymentType,
      userId: userId ?? this.userId,
    );
  }
}

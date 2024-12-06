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
import 'paymentType.dart' as _i3;

abstract class Payment implements _i1.SerializableModel {
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
    required _i3.PaymentType paymentType,
    required int userId,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      guestId: jsonSerialization['guestId'] as int,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i2.Guest.fromJson(
              (jsonSerialization['guest'] as Map<String, dynamic>)),
      chargeDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['chargeDate']),
      dateVoid:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateVoid']),
      amount: (jsonSerialization['amount'] as num).toDouble(),
      description: jsonSerialization['description'] as String,
      paymentType: _i3.PaymentType.fromJson(
          (jsonSerialization['paymentType'] as String)),
      userId: jsonSerialization['userId'] as int,
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

  _i3.PaymentType paymentType;

  int userId;

  Payment copyWith({
    int? id,
    int? guestId,
    _i2.Guest? guest,
    DateTime? chargeDate,
    DateTime? dateVoid,
    double? amount,
    String? description,
    _i3.PaymentType? paymentType,
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

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    required _i3.PaymentType paymentType,
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
    _i3.PaymentType? paymentType,
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

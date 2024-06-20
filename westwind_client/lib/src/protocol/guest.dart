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

abstract class Guest extends _i1.SerializableEntity {
  Guest._({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.isInHouse,
    required this.dateCreate,
    this.dateUpdate,
    required this.rateType,
    required this.staffId,
    required this.companyId,
    this.company,
    required this.rigNumber,
    required this.accountBalance,
  });

  factory Guest({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required bool isInHouse,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required _i2.RateType rateType,
    required int staffId,
    required int companyId,
    _i2.Company? company,
    required int rigNumber,
    required double accountBalance,
  }) = _GuestImpl;

  factory Guest.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Guest(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      firstName: serializationManager
          .deserialize<String>(jsonSerialization['firstName']),
      lastName: serializationManager
          .deserialize<String>(jsonSerialization['lastName']),
      phone:
          serializationManager.deserialize<String>(jsonSerialization['phone']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      isInHouse: serializationManager
          .deserialize<bool>(jsonSerialization['isInHouse']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      rateType: serializationManager
          .deserialize<_i2.RateType>(jsonSerialization['rateType']),
      staffId:
          serializationManager.deserialize<int>(jsonSerialization['staffId']),
      companyId:
          serializationManager.deserialize<int>(jsonSerialization['companyId']),
      company: serializationManager
          .deserialize<_i2.Company?>(jsonSerialization['company']),
      rigNumber:
          serializationManager.deserialize<int>(jsonSerialization['rigNumber']),
      accountBalance: serializationManager
          .deserialize<double>(jsonSerialization['accountBalance']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String firstName;

  String lastName;

  String phone;

  String email;

  bool isInHouse;

  DateTime dateCreate;

  DateTime? dateUpdate;

  _i2.RateType rateType;

  int staffId;

  int companyId;

  _i2.Company? company;

  int rigNumber;

  double accountBalance;

  Guest copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    bool? isInHouse,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    _i2.RateType? rateType,
    int? staffId,
    int? companyId,
    _i2.Company? company,
    int? rigNumber,
    double? accountBalance,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'isInHouse': isInHouse,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'rateType': rateType.toJson(),
      'staffId': staffId,
      'companyId': companyId,
      if (company != null) 'company': company?.toJson(),
      'rigNumber': rigNumber,
      'accountBalance': accountBalance,
    };
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required bool isInHouse,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required _i2.RateType rateType,
    required int staffId,
    required int companyId,
    _i2.Company? company,
    required int rigNumber,
    required double accountBalance,
  }) : super._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          isInHouse: isInHouse,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          rateType: rateType,
          staffId: staffId,
          companyId: companyId,
          company: company,
          rigNumber: rigNumber,
          accountBalance: accountBalance,
        );

  @override
  Guest copyWith({
    Object? id = _Undefined,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    bool? isInHouse,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    _i2.RateType? rateType,
    int? staffId,
    int? companyId,
    Object? company = _Undefined,
    int? rigNumber,
    double? accountBalance,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isInHouse: isInHouse ?? this.isInHouse,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      rateType: rateType ?? this.rateType,
      staffId: staffId ?? this.staffId,
      companyId: companyId ?? this.companyId,
      company: company is _i2.Company? ? company : this.company?.copyWith(),
      rigNumber: rigNumber ?? this.rigNumber,
      accountBalance: accountBalance ?? this.accountBalance,
    );
  }
}

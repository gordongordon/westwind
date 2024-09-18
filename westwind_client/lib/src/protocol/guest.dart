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
import 'protocol.dart' as _i2;

abstract class Guest implements _i1.SerializableModel {
  Guest._({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    required this.isInHouse,
    required this.dateCreate,
    this.dateUpdate,
    required this.rateType,
    required this.staffId,
    required this.companyId,
    this.company,
    this.rigNumber,
    required this.accountBalance,
    this.roomGuets,
  });

  factory Guest({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required bool isInHouse,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required _i2.RateType rateType,
    required int staffId,
    required int companyId,
    _i2.Company? company,
    int? rigNumber,
    required double accountBalance,
    List<_i2.RoomGuest>? roomGuets,
  }) = _GuestImpl;

  factory Guest.fromJson(Map<String, dynamic> jsonSerialization) {
    return Guest(
      id: jsonSerialization['id'] as int?,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      isInHouse: jsonSerialization['isInHouse'] as bool,
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
      rateType:
          _i2.RateType.fromJson((jsonSerialization['rateType'] as String)),
      staffId: jsonSerialization['staffId'] as int,
      companyId: jsonSerialization['companyId'] as int,
      company: jsonSerialization['company'] == null
          ? null
          : _i2.Company.fromJson(
              (jsonSerialization['company'] as Map<String, dynamic>)),
      rigNumber: jsonSerialization['rigNumber'] as int?,
      accountBalance: (jsonSerialization['accountBalance'] as num).toDouble(),
      roomGuets: (jsonSerialization['roomGuets'] as List?)
          ?.map((e) => _i2.RoomGuest.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String firstName;

  String lastName;

  String phone;

  String? email;

  bool isInHouse;

  DateTime dateCreate;

  DateTime? dateUpdate;

  _i2.RateType rateType;

  int staffId;

  int companyId;

  _i2.Company? company;

  int? rigNumber;

  double accountBalance;

  List<_i2.RoomGuest>? roomGuets;

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
    List<_i2.RoomGuest>? roomGuets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      if (email != null) 'email': email,
      'isInHouse': isInHouse,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'rateType': rateType.toJson(),
      'staffId': staffId,
      'companyId': companyId,
      if (company != null) 'company': company?.toJson(),
      if (rigNumber != null) 'rigNumber': rigNumber,
      'accountBalance': accountBalance,
      if (roomGuets != null)
        'roomGuets': roomGuets?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuestImpl extends Guest {
  _GuestImpl({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required bool isInHouse,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required _i2.RateType rateType,
    required int staffId,
    required int companyId,
    _i2.Company? company,
    int? rigNumber,
    required double accountBalance,
    List<_i2.RoomGuest>? roomGuets,
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
          roomGuets: roomGuets,
        );

  @override
  Guest copyWith({
    Object? id = _Undefined,
    String? firstName,
    String? lastName,
    String? phone,
    Object? email = _Undefined,
    bool? isInHouse,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    _i2.RateType? rateType,
    int? staffId,
    int? companyId,
    Object? company = _Undefined,
    Object? rigNumber = _Undefined,
    double? accountBalance,
    Object? roomGuets = _Undefined,
  }) {
    return Guest(
      id: id is int? ? id : this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      isInHouse: isInHouse ?? this.isInHouse,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      rateType: rateType ?? this.rateType,
      staffId: staffId ?? this.staffId,
      companyId: companyId ?? this.companyId,
      company: company is _i2.Company? ? company : this.company?.copyWith(),
      rigNumber: rigNumber is int? ? rigNumber : this.rigNumber,
      accountBalance: accountBalance ?? this.accountBalance,
      roomGuets: roomGuets is List<_i2.RoomGuest>?
          ? roomGuets
          : this.roomGuets?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

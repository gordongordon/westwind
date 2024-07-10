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

abstract class Company implements _i1.SerializableModel {
  Company._({
    this.id,
    required this.name,
    required this.contactName,
    required this.phone,
    required this.email,
    required this.dateCreate,
    this.dateUpdate,
    required this.byStaffId,
    this.guests,
  });

  factory Company({
    int? id,
    required String name,
    required String contactName,
    required String phone,
    required String email,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int byStaffId,
    List<_i2.Guest>? guests,
  }) = _CompanyImpl;

  factory Company.fromJson(Map<String, dynamic> jsonSerialization) {
    return Company(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      contactName: jsonSerialization['contactName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
      byStaffId: jsonSerialization['byStaffId'] as int,
      guests: (jsonSerialization['guests'] as List?)
          ?.map((e) => _i2.Guest.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String contactName;

  String phone;

  String email;

  DateTime dateCreate;

  DateTime? dateUpdate;

  int byStaffId;

  List<_i2.Guest>? guests;

  Company copyWith({
    int? id,
    String? name,
    String? contactName,
    String? phone,
    String? email,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? byStaffId,
    List<_i2.Guest>? guests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'contactName': contactName,
      'phone': phone,
      'email': email,
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
      'byStaffId': byStaffId,
      if (guests != null)
        'guests': guests?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyImpl extends Company {
  _CompanyImpl({
    int? id,
    required String name,
    required String contactName,
    required String phone,
    required String email,
    required DateTime dateCreate,
    DateTime? dateUpdate,
    required int byStaffId,
    List<_i2.Guest>? guests,
  }) : super._(
          id: id,
          name: name,
          contactName: contactName,
          phone: phone,
          email: email,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          byStaffId: byStaffId,
          guests: guests,
        );

  @override
  Company copyWith({
    Object? id = _Undefined,
    String? name,
    String? contactName,
    String? phone,
    String? email,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
    int? byStaffId,
    Object? guests = _Undefined,
  }) {
    return Company(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
      byStaffId: byStaffId ?? this.byStaffId,
      guests: guests is List<_i2.Guest>? ? guests : this.guests?.clone(),
    );
  }
}

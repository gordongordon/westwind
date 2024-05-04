/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Company extends _i1.SerializableEntity {
  Company._({
    this.id,
    required this.name,
    required this.contactName,
    required this.phone,
    required this.email,
    required this.dateCreate,
    this.dateUpdate,
    required this.byStaffId,
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
  }) = _CompanyImpl;

  factory Company.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Company(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      contactName: serializationManager
          .deserialize<String>(jsonSerialization['contactName']),
      phone:
          serializationManager.deserialize<String>(jsonSerialization['phone']),
      email:
          serializationManager.deserialize<String>(jsonSerialization['email']),
      dateCreate: serializationManager
          .deserialize<DateTime>(jsonSerialization['dateCreate']),
      dateUpdate: serializationManager
          .deserialize<DateTime?>(jsonSerialization['dateUpdate']),
      byStaffId:
          serializationManager.deserialize<int>(jsonSerialization['byStaffId']),
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

  Company copyWith({
    int? id,
    String? name,
    String? contactName,
    String? phone,
    String? email,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? byStaffId,
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
    };
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
  }) : super._(
          id: id,
          name: name,
          contactName: contactName,
          phone: phone,
          email: email,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
          byStaffId: byStaffId,
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
    );
  }
}

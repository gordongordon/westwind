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
import 'permissionType.dart' as _i2;

abstract class Staff implements _i1.SerializableModel {
  Staff._({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    this.timelogout,
    required this.timelogin,
    required this.permissionType,
    required this.dateCreate,
    this.dateUpdate,
  });

  factory Staff({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    DateTime? timelogout,
    required DateTime timelogin,
    required _i2.PermissionType permissionType,
    required DateTime dateCreate,
    DateTime? dateUpdate,
  }) = _StaffImpl;

  factory Staff.fromJson(Map<String, dynamic> jsonSerialization) {
    return Staff(
      id: jsonSerialization['id'] as int?,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
      timelogout: jsonSerialization['timelogout'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timelogout']),
      timelogin:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timelogin']),
      permissionType: _i2.PermissionType.fromJson(
          (jsonSerialization['permissionType'] as String)),
      dateCreate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreate']),
      dateUpdate: jsonSerialization['dateUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateUpdate']),
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

  String password;

  DateTime? timelogout;

  DateTime timelogin;

  _i2.PermissionType permissionType;

  DateTime dateCreate;

  DateTime? dateUpdate;

  Staff copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    DateTime? timelogout,
    DateTime? timelogin,
    _i2.PermissionType? permissionType,
    DateTime? dateCreate,
    DateTime? dateUpdate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      if (timelogout != null) 'timelogout': timelogout?.toJson(),
      'timelogin': timelogin.toJson(),
      'permissionType': permissionType.toJson(),
      'dateCreate': dateCreate.toJson(),
      if (dateUpdate != null) 'dateUpdate': dateUpdate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffImpl extends Staff {
  _StaffImpl({
    int? id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    DateTime? timelogout,
    required DateTime timelogin,
    required _i2.PermissionType permissionType,
    required DateTime dateCreate,
    DateTime? dateUpdate,
  }) : super._(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          password: password,
          timelogout: timelogout,
          timelogin: timelogin,
          permissionType: permissionType,
          dateCreate: dateCreate,
          dateUpdate: dateUpdate,
        );

  @override
  Staff copyWith({
    Object? id = _Undefined,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    Object? timelogout = _Undefined,
    DateTime? timelogin,
    _i2.PermissionType? permissionType,
    DateTime? dateCreate,
    Object? dateUpdate = _Undefined,
  }) {
    return Staff(
      id: id is int? ? id : this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      timelogout: timelogout is DateTime? ? timelogout : this.timelogout,
      timelogin: timelogin ?? this.timelogin,
      permissionType: permissionType ?? this.permissionType,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate is DateTime? ? dateUpdate : this.dateUpdate,
    );
  }
}
